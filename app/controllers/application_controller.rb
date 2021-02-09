class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters,
   if: :devise_controller?

  def current_customer?
    customer_id = params[:customer_id]
    id = params[:id]
    unless customer_id == current_customer.id.to_s || id == current_customer.id.to_s
      redirect_to root_path
    end
  end
  

  def destroy_all
    customer = Customer.find(params[:customer_id])
    customer.cart_items.destroy_all
  end

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])

    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name_family, :name_first, :name_family_kana, :name_first_kana, :email, :postal_code, :address, :phone_number, :password ])

  end
  
  
end
