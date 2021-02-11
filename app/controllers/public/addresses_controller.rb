class Public::AddressesController < ApplicationController

before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to public_addresses_path, success: "配送先の新規登録が完了しました。"
    else
      @addresses = Address.where(customer_id: current_customer.id)
      render action: :index
    end
  end

  def edit
    @address =Address.find(params[:id])
  end

  def update
    @address =Address.find(params[:id])
    if @address.update(address_params)
      redirect_to public_addresses_path(@address.id)
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to public_addresses_path, success: "配送先の削除が完了しました。"
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end