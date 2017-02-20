class ChargesController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_total_amount, only: [:create,:new,:payment_success]
  after_filter :remove_cart_items

  def new

  end

  def create
    
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
     @order = Order.where(user_id: current_user.id, order_status: 'pending').first
     @order.order_status = 'successfull'
     @order.save

     @cart_items = current_user.cart_items
     @cart_items.each do |cart_item|
      @order_item = Orderitem.new(order_id: @order.id, product_id: cart_item.product_id, quantity: cart_item.quantity,
      user_id: current_user.id, amount: @final_total)
      @order_item.save
     end
     @addresses = Address.find(@order.address_id)
     
     @orderitems = @order.orderitems
     @transaction = Transaction.new(user_id: current_user.id, order_id: @order.id,token: params[:stripeToken], charge_id: charge[:id], amount: charge[:amount]/100, paid: charge[:paid], refunded: charge[:refunded], status: charge[:status])
     @transaction.save
     OrderMailer.order_email(@addresses,@orderitems).deliver
    end

    redirect_to  payment_charges_path(order_id: @order)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def payment

    @order = Order.find(params[:order_id])
    
    if current_user.orders.pluck(:id).include?(@order.id)
      @addresses = Address.find(@order.address_id)
      @orderitems = @order.orderitems
      @subtotal = 0 
      @orderitems.each do |item|                   
        @subtotal += item.product.price * item.quantity            
      end
      @shipping_charges = 40.0
      @tax = 0.04 * @subtotal
      @final_total = @subtotal + @shipping_charges + @tax
      @transaction = Transaction.find_by(order_id: @order.id)
    else
      redirect_to root_path
    end
    
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
      
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:payment_gateway_id, :transection_id, :order_status, :grand_total, :shipping_charges, :user_id, :address_id)
    end
end
