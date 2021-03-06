class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!, except: :check


  def show
    @customer = Customer.find(params[:id])
  end


  def edit
    @customer = Customer.find(params[:id])
  end

  def check

  end

  def out
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end


  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to public_customer_path(@customer)
    else
       render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number,
      :email,
      :is_active
    )
  end

end