class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]
  #before_action :set_sub_total, only: [:index,:update]
  # GET /cart_items
  # GET /cart_items.json
  def index

    @cart_items = current_user.cart_items.all
    #@cart_items = current_user.cart_items.all
    @sub_total = 0
    @cart_items.each do |item|
      @sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    @tax = 0.04 * @sub_total
    @shipping_cost = 40
    @final_total = @tax + @sub_total + @shipping_cost
      #binding.pry 
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
    #@product = Product.all
    @cart_item = CartItem.where(product_id: params[:product_id], user_id: current_user.id).first
    #binding.pry
    if @cart_item.present?
      #binding.pry
      if params[:boolean].present?
        a = params["cart_item"]["quantity"]
        @cart_item.quantity += a.to_i
      else
      @cart_item.quantity += 1
      end
      #@product.quantity -= 1 
    else
      if params[:boolean].present?
        @cart_item = CartItem.new(product_id: params[:product_id],user_id: current_user.id)
        b = params["cart_item"]["quantity"]
        puts @cart_item.quantity
        @cart_item.quantity += b.to_i
        #puts "****************************"
        #puts @cart_item.quantity
      else
        @cart_item = CartItem.new(product_id: params[:product_id],user_id: current_user.id)
        @cart_item.quantity += 1
      end
    end

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to :back, notice: 'Cart item was successfully created.' }
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
    @cart_item = CartItem.find(params[:id])
    #binding.pry
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
   
    #binding.pry

    respond_to do |format|
      if @cart_item.save
        @cart_items = current_user.cart_items.all
        @sub_total1 = 0
        @cart_items.each do |item|
          @sub_total1 += (item.product.price.to_i * item.quantity.to_i) 
        end
        @tax = 0.04 * @sub_total1
        @shipping_cost = 40
        @final_total = @tax + @shipping_cost + @sub_total1

        format.html { redirect_to :back, notice: 'Cart item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
    #gon.sub_total = @sub_total
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    
    

    
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = current_user.cart_items.all
    #@cart_items = current_user.cart_items.all
    @sub_total = 0
    @cart_items.each do |item|
      @sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    @tax = 0.04 * @sub_total
    @shipping_cost = 40
    @final_total = @tax + @sub_total + @shipping_cost
    
    respond_to do |format|
      format.html { redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      #@cart_item = CartItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(:quantity, :user_id, :product_id)
    end

end
