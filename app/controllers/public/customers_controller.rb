class Public::CustomersController < ApplicationController


  def show
    @customer = Customer.find(params[:id])
    
  end

  def edit
    @customer = Customer.find(params[:id])
    
  end

  def check
    
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
      :name_family,
      :name_first,
      :name_family_kana,
      :name_first_kana,
      :postal_code,
      :address,
      :phone_number,
      :email
    )
  end

end
