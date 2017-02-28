class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = Address.all
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit

  end

  def create
    @address = current_user.addresses.new(address_params)
    respond_to do |format|
      if @address.save
        format.html { redirect_to :back, notice: 'Address was successfully created.' }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:status] == "delete"
      @address.update_attribute(status: "inactive")
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

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Address was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :layout => false}
    end
  end

  private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.require(:address).permit(:user_id, :name, :email, :address_one, :address_two, :zip_code, :country, :state, :mobile_number, :address_type, :status)
    end
end
