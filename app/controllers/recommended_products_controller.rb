class RecommendedProductsController < ApplicationController
  before_action :set_recommended_product, only: [:show, :edit, :update, :destroy]

  # GET /recommended_products
  # GET /recommended_products.json
  def index
    @recommended_products = RecommendedProduct.all
  end

  # GET /recommended_products/1
  # GET /recommended_products/1.json
  def show
  end

  # GET /recommended_products/new
  def new
    @recommended_product = RecommendedProduct.new
  end

  # GET /recommended_products/1/edit
  def edit
  end

  # POST /recommended_products
  # POST /recommended_products.json
  def create
    @recommended_product = RecommendedProduct.new(recommended_product_params)
    respond_to do |format|
      if @recommended_product.save
        format.html { redirect_to @recommended_product, notice: 'Recommended product was successfully created.' }
        format.json { render :show, status: :created, location: @recommended_product }
      else
        format.html { render :new }
        format.json { render json: @recommended_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommended_products/1
  # PATCH/PUT /recommended_products/1.json
  def update
    respond_to do |format|
      if @recommended_product.update(recommended_product_params)
        format.html { redirect_to @recommended_product, notice: 'Recommended product was successfully updated.' }
        format.json { render :show, status: :ok, location: @recommended_product }
      else
        format.html { render :edit }
        format.json { render json: @recommended_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommended_products/1
  # DELETE /recommended_products/1.json
  def destroy
    @recommended_product.destroy
    respond_to do |format|
      format.html { redirect_to recommended_products_url, notice: 'Recommended product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommended_product
      @recommended_product = RecommendedProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recommended_product_params
      params.fetch(:recommended_product, {})
    end
end
