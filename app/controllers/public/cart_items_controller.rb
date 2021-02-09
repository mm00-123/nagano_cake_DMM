class Public::CartItemsController < ApplicationController
  
  before_action :authenticate_customer!
  
  def index
    @cart_item = CartItem.new
    @total = 0
    @tax = 1.1
    @cart_item_customer = CartItem.where(customer_id: current_customer.id)
  end

  def create
    cart_item = CartItem.new(cart_item_params)
      if cart_item.save
        redirect_to public_cart_items_path
      else
        redirect_to public_item_path(cart_item.item_id)
      end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to action: 'index'
    else
      @cart_items = CartItem.all
      @total = 0
      @tax = 1.1
      @cart_item_customer = CartItem.where(customer_id: current_customer.id)
      @customer = Customer.find(params[:customer_id])
      render :index
    end
  end

  def destroy
    CartItem.find_by(id: params[:id], customer_id: params[:customer_id]).destroy
    redirect_to action: 'index'
  end

  def destroy_all
    customer = Customer.find(params[:customer_id])
    customer.cart_items.destroy_all
    redirect_to action: 'index'
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id).merge(customer_id: current_customer.id)
  end

end
