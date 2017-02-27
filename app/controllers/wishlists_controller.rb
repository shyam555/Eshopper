class WishlistsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_wishlist, only: [:show, :edit, :update]

  # GET /wishlists
  # GET /wishlists.json
  def index
    @wishlists = current_user.wishlists
  end

  # GET /wishlists/1
  # GET /wishlists/1.json
  def show
  end

  # GET /wishlists/new
  def new
    @wishlist = Wishlist.new
  end

  # GET /wishlists/1/edit
  def edit
  end

  # POST /wishlists
  # POST /wishlists.json
  def create
    @product_id = params[:product_id]
    @product = Product.find_by(id: params[:product_id])
    @wishlist = current_user.wishlists.find_or_initialize_by(user_id: current_user.id, product_id: @product_id)
    respond_to do |format|
      if @wishlist.save
        format.html { redirect_to :back, notice: 'Wishlist was successfully created.' }
        format.json { render :show, status: :created, location: @wishlist }
        format.js
      else
        format.html { render :new }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wishlists/1
  # PATCH/PUT /wishlists/1.json
  def update
    respond_to do |format|
      if @wishlist.update(wishlist_params)
        format.html { redirect_to @wishlist, notice: 'Wishlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @wishlist }
      else
        format.html { render :edit }
        format.json { render json: @wishlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wishlists/1
  # DELETE /wishlists/1.json
  def destroy
    @wishlist = current_user.wishlists.find(params[:id])
    @product = Product.find_by(id: @wishlist.product_id)
    @wishlist.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Wishlist was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wishlist
      @wishlist = Wishlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wishlist_params
      params.require(:wishlist).permit(:user_id, :product_id)
    end
end
