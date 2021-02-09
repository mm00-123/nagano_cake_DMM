class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.where(is_active: true).page(params[:page]).per(12)
  end

  def show
    @item = Item.find(params[:id])
    @item_tax_included_price = (@item.price)
    if customer_signed_in?
      @customer = Customer.find(current_customer.id)
    end
    @cart_item = CartItem.new
  end

end
