class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_total_amount, only: [:create,:new,:show]
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
    #binding.pry
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_id = params[:id]
    #binding.pry
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    #@order = Order.new(order_params)

    @order = current_user.orders.where(user_id: current_user.id,order_status: 'pending').first
    
    if @order.present?
      #@order.user_id = current_user.id
      @order.address_id = params[:address_id]
      #@order.order_status = 'pending'
      @order.grand_total = @final_total
      @order.save
      #binding.pry
    else  
      @order = Order.new(:user_id => current_user.id, :address_id => params[:address_id], :order_status => 'pending', :grand_total => @final_total)
      @order.save
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def cancel_order
    @order= Order.find(params['order_id'])
    @order.order_status = 'cancel'
    @order.save
    @transaction = Transaction.find_by(order_id: @order.id)
    @charge_id = @transaction.charge_id

    charge = Stripe::Charge.retrieve(@charge_id)
    charge.refund
    @address = Address.find(@order.address_id)
    CancelMailer.cancel_order(@order,@address).deliver

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
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:payment_gateway_id, :transection_id, :order_satus, :grand_total, :shipping_charges, :user_id, :address_id)
    end
end
