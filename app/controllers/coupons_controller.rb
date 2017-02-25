class CouponsController < ApplicationController
  include CouponsHelper
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
     @coupan = Coupon.find_by(code: params[:code])
      if @coupan.present?
        @used_coupon = CouponUsed.find_by(user_id: current_user.id, coupon_id: @coupan.id )
        if @used_coupon.present?
          @sub_total, @discount, @tax, @shipping_cost, @final_total = amount(current_user)
          @message = "Coupon Alredy Used.."
        else
          session[:coupon_code] = params[:code]
          @sub_total, @discount, @tax, @shipping_cost, @final_total = amount(current_user)
          @message = "Coupon Applied"
        end
      else
        @sub_total, @discount, @tax, @shipping_cost, @final_total = amount(current_user)
        @message = "Invalid Coupon..!!"
      end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Coupon was successfully applied.' }
      format.js
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
    @cart_items = current_user.cart_items
    @sub_total1, @discount, @tax, @shipping_cost, @final_total = Coupon.destroy_coupon(@cart_items, session[:coupon_code])
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
