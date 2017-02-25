class ChargesController < ApplicationController
  include ChargesHelper
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_total_amount, only: [:create]
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
     @transaction = Transaction.new(user_id: current_user.id, order_id: @order.id, token: params[:stripeToken], charge_id: charge[:id], amount: charge[:amount]/100, paid: charge[:paid], refunded: charge[:refunded], status: charge[:status])
     @transaction.save
     OrderMailer.order_email(@addresses, @orderitems, session[:coupon_code], current_user).deliver
     if session[:coupon_code].present?
      @coupon_code = session[:coupon_code]
      @coupon = Coupon.find_by(code: @coupon_code)
      @coupon_used = CouponUsed.new(user_id: current_user.id, order_id: @order.id, coupon_id: @coupon.id )
      @coupon_used.save
      reset_session
     end 
    end
    redirect_to  payment_charge_path(@order)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def payment
    @order = Order.find(params[:id])
    if current_user.orders.pluck(:id).include?(@order.id)
      @addresses = Address.find(@order.address_id)
      @orderitems = @order.orderitems
      @subtotal, @discount, @tax, @shipping_charges, @final_total= payment_page(@orderitems)
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
      @sub_total, @discount, @tax, @shipping_cost, @final_total = set_total(current_user)
     end

     def remove_cart_items
      current_user.cart_items.destroy_all
     end
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:payment_gateway_id, :transection_id, :order_status, :grand_total, :shipping_charges, :user_id, :address_id)
    end
end
