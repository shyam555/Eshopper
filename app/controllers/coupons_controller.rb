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
    #if CouponUsed.find_by(user_id: current_user.id,coupon_id: @coupon.id)
    @coupon = Coupon.find_by(code: params[:code])
    if @coupon.present?
      session[:coupon_code] = params[:code]
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Coupon was successfully applied.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Invalid Coupon code' }
      end
    end

    # respond_to do |format|
    #   if @coupon.save
    #     format.html { redirect_to :back, notice: 'Coupon was successfully created.' }
    #     format.json { render :show, status: :created, location: @coupon }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @coupon.errors, status: :unprocessable_entity }
    #   end
    # end
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
    end
    #@coupon.destroy
    respond_to do |format|
    format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_coupon
    #   @coupon = Coupon.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.fetch(:coupon, {})
    end
end
