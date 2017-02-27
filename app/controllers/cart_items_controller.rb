class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  def index
    @cart_items = current_user.cart_items
    @sub_total, @discount, @tax, @shipping_cost, @final_total = CartItem.cart_total(@cart_items,session[:coupon_code])
  end

  # GET /cart_items/1
  # GET /cart_items/1.json
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /cart_items
  # POST /cart_items.json
  def create
    @cart_item = current_user.cart_items.where(product_id: params[:product_id]).first
    if @cart_item.present?
      if params[:boolean].present?
        quantity_one = params["cart_item"]["quantity"]
        @cart_item.quantity += quantity_one.to_i
      else
        @cart_item.quantity += 1
      end
    else
      if params[:boolean].present?
        @cart_item = current_user.cart_items.create(product_id: params[:product_id])
        quantity_two = params["cart_item"]["quantity"]
        @cart_item.quantity += quantity_two.to_i
      else
        @cart_item = current_user.cart_items.create(product_id: params[:product_id])
        @cart_item.quantity += 1
      end
    end
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to :back, notice: 'Product successfully added into your cart.' }
        format.json { render :show, status: :created, location: @cart_item }
        format.js
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    if params[:qty] == "minus"
      if @cart_item.quantity == 1
        @cart_item.quantity=1
      else
        @cart_item.quantity -= 1
      end
    elsif params[:qty] == "plus"
      @cart_item.quantity += 1
    else
      quantity = params["quantity"].to_i
      if params[:quantity] == ""
        @cart_item.quantity = @cart_item.quantity
      elsif params[:quantity].to_i < 1
        @cart_item.quantity = 1
      else
        @cart_item.quantity = quantity
      end
    end
    respond_to do |format|
      if @cart_item.save
        @cart_items = current_user.cart_items
        @sub_total, @discount, @tax, @shipping_cost, @final_total = CartItem.cart_total(@cart_items,session[:coupon_code])
        format.html { redirect_to :back, notice: 'Cart item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    @cart_items = current_user.cart_items
    @sub_total, @discount, @tax, @shipping_cost, @final_total = CartItem.cart_total(@cart_items, session[:coupon_code])
    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Product successfully removed from cart.' }
      format.json { head :no_content }
      format.js   { render :layout => false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity, :user_id, :product_id)
    end
end
