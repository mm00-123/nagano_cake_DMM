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

  def after_sign_in_path_for(resource)
      case resource
        when Admin
          admin_homes_top_path
        when Customer
          public_customer_path(resource)
      end
  end

  def after_sign_out_path_for(resource)
      case resource
        when :admin
          new_admin_session_path
        when :customer
          root_path
      end
  end


  def destroy_all
    customer = Customer.find(params[:customer_id])
    customer.cart_items.destroy_all
  end

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])

    devise_parameter_sanitizer.permit(:sign_up, keys: [ :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :password ])

  end


end
