class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  
  protected

  def configure_permitted_parameters
    added_attrs = [:firstname, :lastname, :email, :password, :password_confirmation, :remember_me, :status]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def record_not_found(exception)
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end
end
