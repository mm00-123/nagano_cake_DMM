class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.where(is_sale_status: true).page(params[:page]).per(12)
    @genres = Genre.where(is_invalid_flag: true).page(params[:page]).per(5)
  end

  def show
    @item = Item.find(params[:id])
    @item_tax_included_price = (@item.price * 1.1)
    @genres = Genre.where(is_invalid_flag: true).page(params[:page]).per(5)
    if member_signed_in?
      @customer = Customer.find(current_customer.id)
    end
    @cart_item = CartItem.new
  end

end
