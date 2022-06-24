class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_url
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number
    ])
  end
  
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  def authenticate_customer
    @customer = current_customer
    if @customer == nil
      redirect_to new_customer_session_path
    end
  end
end
