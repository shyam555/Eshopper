class BrandsController < ApplicationController
  before_action :set_brand, only: [:index, :show, :update, :destroy]
  before_action :set_brands, only: [:index, :show]

  def index
    @categories = Category.all
    @products = Product.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
    @category = Category.first
  end

  def show
    @subcategory = @brand.categories
    @categories = Category.all.where(category_id: nil)
    @category = Category.find(params[:sub_category] || params[:category_id])
    @product = @category.products.where(brand_id: @brand.id)
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    respond_to do |format|
      if @brand.save
        format.html { redirect_to @brand, notice: 'Brand was successfully created.' }
        format.json { render :show, status: :created, location: @brand }
      else
        format.html { render :new }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @brand.update(brand_params)
        format.html { redirect_to @brand, notice: 'Brand was successfully updated.' }
        format.json { render :show, status: :ok, location: @brand }
      else
        format.html { render :edit }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to brands_url, notice: 'Brand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand = Brand.find(params[:id])
    end

    def set_brands
      @brands = Brand.all
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def brand_params
      params.require(:brand).permit(:name, :short_description, :long_description, :status, :category_id)
    end
end
