class Public::AddressesController < ApplicationController
  
  before_action :current_customer?

  def index
    @shipping = Address.new
    @shippings = Address.all
    @customer = Customer.find(params[:customer_id])
  end

  def edit
    @shipping_update = Address.find_by(id: params[:id], customer_id: params[:customer_id])
    @shipping = Address.find(params[:id])
    @shippings = Address.all
    @customer = Customer.find(params[:customer_id])
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @shipping = Address.new(address_params)
    @shipping.customer_id = current_customer.id
    if @shipping.save
      redirect_to customer__addresses_path
    else
      render :index
    end
  end

  def update
    @customer = Customer.find(params[:member_id])
    @shipping = Address.find(params[:id])
    @shipping_update = Address.find_by(id: params[:id], customer_id: params[:customer_id])
    if @shipping_update.update(address_params)
      redirect_to customer_addresses_path
    else
      render :edit
    end
  end

  def destroy
    Address.find_by(id: params[:id], customer_id: params[:customer_id]).destroy
    redirect_to customer_addresses_path
  end

  private
  def shipping_params
    params.require(:address).permit(:postal_code, :address, :receiver)
  end

  
end
