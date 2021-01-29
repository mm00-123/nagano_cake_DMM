class Admin::CustomersController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      render :edit
    end
  end

private

def customer_params
  params.require(:customer).permit(
    :name_family, 
    :name_first, 
    :name_family_kana, 
    :name_first_kana,
    :postal_code,
    :address,
    :phone_number,
    :email,
    :is_withdrawal_flag
  )
end

end
