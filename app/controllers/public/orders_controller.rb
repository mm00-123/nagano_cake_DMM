class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.page(params[:page]).reverse_order
    @order_items = OrderItem.all
    @total = 0
    @postage = 800
  end

  def show

  end

  def new

  end

  def about

  end

  def create

  end

  def thanx

  end

  private
  def order_params
    params.require(:order).permit(:order_status, :postal_code, :name, :address, :postage, :payment_method, :total)
  end
end
