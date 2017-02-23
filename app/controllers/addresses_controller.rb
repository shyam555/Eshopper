class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
    @address = Address.find(params[:id])
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address_bill = current_user.addresses.new(address_params)

    respond_to do |format|
      if @address_bill.save
        format.html { redirect_to :back, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    @address= Address.find(params[:id])
    if params[:status] == "delete"
      @address.update(status: 'inactive')
      @address.save
      redirect_to checkouts_path
    else
      respond_to do |format|
        if @address.update(address_params)
          format.html { redirect_to :back, notice: 'Address was successfully updated.' }
          format.json { render :show, status: :ok, location: @address }
        else
          format.html { render :edit }
          format.json { render json: @address.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :layout => false}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params

      params.require(:address).permit(:user_id, :name, :email, :address_one, :address_two, :zip_code, :country, :state, :mobile_number, :address_type, :status)
    end
end
