class ChargesController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_total_amount, only: [:create,:new,:payment_success]
  after_filter :remove_cart_items
  def new

    # @cart_items = current_user.cart_items
    # @sub_total = 0
    # @cart_items.each do |item|
    #   @sub_total += (item.product.price.to_i * item.quantity.to_i) 
    # end
    # @tax = 0.04 * @sub_total
    # @shipping_cost = 40
    # @final_total = @tax + @sub_total + @shipping_cost


    # @order = current_user.orders.where(user_id: current_user.id,order_status: 'pending').first
    
    # if @order.present?
    #   #@order.user_id = current_user.id
    #   @order.address_id = params[:address_id]
    #   #@order.order_status = 'pending'
    #   @order.grand_total = @final_total
    #   @order.save
    #   #binding.pry
    # else  
    #   @order = Order.new(:user_id => current_user.id, :address_id => params[:address_id], :order_status => 'pending', :grand_total => @final_total)
    #   @order.save
    #end
  end

  def create
    # Amount in cents
    #@amount = 50000

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @final_total.to_i*100,
      :description => 'Rails Stripe customer',
      :currency    => 'inr'
    )
    
    if params[:stripeToken].present?
     @order = Order.where(user_id: current_user.id,order_status: 'pending').first
     #binding.pry
     @order.order_status = 'sucessfull'
     @order.save

     @cart_items = current_user.cart_items
     @cart_items.each do |cart_item|
      @order_item = Orderitem.new(order_id: @order.id,product_id: cart_item.product_id,quantity: cart_item.quantity,
        user_id: current_user.id,amount: @final_total)
      #binding.pry
      @order_item.save
     end
     @addresses = Address.find(@order.address_id)
     #@order = Order.find(params[:order_id])
     #@addresses = Address.find(@order.address_id)
     @orderitems = @order.orderitems
     OrderMailer.order_email(@addresses,@orderitems).deliver
    end

    redirect_to  payment_charges_path(order_id: @order)
    #@cart_items.destroy_all
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def payment
    @order = Order.find(params[:order_id])
    @addresses = Address.find(@order.address_id)
    @orderitems = @order.orderitems
    #binding.pry
  end

  private
    # Use callbacks to share common setup or constraints between actions.
     def set_order
       @order = Order.find(params[:id])
     end

     def set_total_amount
      @cart_items = current_user.cart_items
      @sub_total = 0
      @cart_items.each do |item|
        @sub_total += (item.product.price.to_i * item.quantity.to_i) 
      end
      @tax = 0.04 * @sub_total
      @shipping_cost = 40
      @final_total = @tax + @sub_total + @shipping_cost
     end

     def remove_cart_items
      current_user.cart_items.destroy_all
     end
     #def send_email
      
     #end  
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:payment_gateway_id, :transection_id, :order_status, :grand_total, :shipping_charges, :user_id, :address_id)
    end
end
