class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show, :edit, :update, :destroy]

  # GET /checkouts
  # GET /checkouts.json
  def index
    @checkouts = Checkout.all
    @addresses = Address.new

    @cart_items = current_user.cart_items.all
    @sub_total = 0
    @discount = 0
    @cart_items.each do |item|
      @sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end

    if session[:coupon_code].present?
      @coupon = Coupon.find_by(code: session[:coupon_code])
      @percent_off = @coupon.percent_off
      @discount = ((@percent_off * @sub_total) / 100)
      #binding.pry
      @tax = 0.04 * @sub_total
      @shipping_cost = 40
      @final_total = @tax + @sub_total + @shipping_cost - @discount
    else
      @tax = 0.04 * @sub_total
      @shipping_cost = 40
      @final_total = @tax + @sub_total + @shipping_cost
    end
  end

  # GET /checkouts/1
  # GET /checkouts/1.json
  def show
  end

  # GET /checkouts/new
  def new
    @checkout = Checkout.new
  end

  # GET /checkouts/1/edit
  def edit
  end

  # POST /checkouts
  # POST /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to @checkout, notice: 'Checkout was successfully created.' }
        format.json { render :show, status: :created, location: @checkout }
      else
        format.html { render :new }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkouts/1
  # PATCH/PUT /checkouts/1.json
  def update
    respond_to do |format|
      if @checkout.update(checkout_params)
        format.html { redirect_to @checkout, notice: 'Checkout was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.json
  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def payment_review
    @coupon = Coupon.new
    @checkouts = Checkout.all
    @addresses = Address.new

     @cart_items = current_user.cart_items.all
     @sub_total = 0
     @discount = 0
     @cart_items.each do |item|
       @sub_total += (item.product.price.to_i * item.quantity.to_i) 
     end

    if session[:coupon_code].present?
      @coupon = Coupon.find_by(code: session[:coupon_code])
      @percent_off = @coupon.percent_off
      @discount = ((@percent_off * @sub_total) / 100)
      #binding.pry
      @tax = 0.04 * @sub_total
      @shipping_cost = 40
      @final_total = @tax + @sub_total + @shipping_cost - @discount
    else
      @tax = 0.04 * @sub_total
      @shipping_cost = 40
      @final_total = @tax + @sub_total + @shipping_cost
    end
     @address_id = params[:address_id]
  end

  def check_coupon_code

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkout_params
      params.fetch(:checkout, {})
    end
end
