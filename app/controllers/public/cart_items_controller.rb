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
        redirect_to public_cart_items_path(cart_item.item_id)
      end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(amount: params[:cart_item][:amount])
      redirect_to action: 'index'
    else
      @cart_items = CartItem.all
      @total = 0
      @tax = 1.1
      @cart_item_customer = CartItem.where(customer_id: current_customer.id)
      @customer = current_customer
      render :index
    end
  end

  def destroy
    @cart_items = CartItem.find(params[:id])
    if @cart_items.destroy
    redirect_to public_cart_items_path,success: '商品の削除が完了しました。'
    else
      render :index, danger: "商品の削除が出来ませんでした"
    end
  end

  def destroy_all
    customer = Customer.find(current_customer.id)
    if customer.cart_items.destroy_all
      redirect_to public_cart_items_path,success: 'カート内の商品を全て削除しました。'
    else
      render :index, danger: "カート内の商品を削除出来ませんでした。"
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id).merge(customer_id: current_customer.id)
  end

end
