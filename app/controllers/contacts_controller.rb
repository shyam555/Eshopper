class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /contacts
  # GET /contacts.json
  def index
    @contact = Contact.new
    @contacts = Contact.all
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    #binding.pry
    @contact = Contact.new(user_id: current_user.id,name: params["contact"]["name"],email: params["contact"]["email"], subject: params["contact"]["subject"], message: params["contact"]["message"], reply: "")
    respond_to do |format|
      if @contact.save
        format.html { redirect_to :back , notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
        format.js
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(message: params["contact"]["message"], reply: params["contact"]["reply"])
         CancelMailer.reply_mailer(@contact).deliver
         @contact.destroy
        format.html { redirect_to :back, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit({:user_id => ["current_user.id"]} , :name, :email, :subject, :message)
    end
end
