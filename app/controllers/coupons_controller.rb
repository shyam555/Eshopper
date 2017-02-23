class CouponsController < ApplicationController
  #before_action :set_coupon, only: [:show, :edit, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.find_by(code: params[:code])
    if @coupon.present?
      @coupon_used = CouponUsed.find_by(user_id: current_user.id, coupon_id: @coupon.id )
      if @coupon_used.present?
        @cart_items = current_user.cart_items.all
        @sub_total1 = 0
        @discount = 0
        @cart_items.each do |item|
          @sub_total1 += (item.product.price.to_i * item.quantity.to_i) 
        end
        @tax = 0.04 * @sub_total1
        @shipping_cost = 40
        @final_total = @tax + @sub_total1 + @shipping_cost
        @message = "Coupon already used."
      else 
        session[:coupon_code] = params[:code]
        @cart_items = current_user.cart_items.all
        @sub_total1 = 0
        @discount = 0
        @cart_items.each do |item|
          @sub_total1 += (item.product.price.to_i * item.quantity.to_i) 
        end
        if session[:coupon_code].present?
          @coupon = Coupon.find_by(code: session[:coupon_code])
          @percent_off = @coupon.percent_off
          @discount = ((@percent_off * @sub_total1) / 100)
          @tax = 0.04 * @sub_total1
          @shipping_cost = 40
          @final_total = @tax + @sub_total1 + @shipping_cost - @discount
          @message = "Applied successfully."
        else
          @tax = 0.04 * @sub_total1
          @shipping_cost = 40
          @final_total = @tax + @sub_total1 + @shipping_cost
        end
      end
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Coupon was successfully applied.' }
        format.js
      end
    else
      @cart_items = current_user.cart_items.all
      @sub_total1 = 0
      @discount = 0
      @cart_items.each do |item|
        @sub_total1 += (item.product.price.to_i * item.quantity.to_i) 
      end
      @tax = 0.04 * @sub_total1
      @shipping_cost = 40
      @final_total = @tax + @sub_total1 + @shipping_cost
      @message ='Invalid Coupon code'
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    if session[:coupon_code].present?
      session[:coupon_code] = nil
      @message = "Coupon Removed"
    end
    @cart_items = current_user.cart_items.all
    @sub_total1 = 0
    @discount = 0
    @cart_items.each do |item|
      @sub_total1 += (item.product.price.to_i * item.quantity.to_i) 
    end
    if session[:coupon_code].present?
      @coupon = Coupon.find_by(code: session[:coupon_code])
      @percent_off = @coupon.percent_off
      @discount = ((@percent_off * @sub_total1) / 100)
      @tax = 0.04 * @sub_total1
      @shipping_cost = 40
      @final_total = @tax + @sub_total1 + @shipping_cost - @discount
    else
      @tax = 0.04 * @sub_total1
      @shipping_cost = 40
      @final_total = @tax + @sub_total1 + @shipping_cost
    end
    respond_to do |format|
    format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.fetch(:coupon, {})
    end
end
