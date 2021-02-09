class Public::OrdersController < ApplicationController
  
  before_action :destroy_all, only: [:completion]

  def index
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page]).reverse_order.per(5)
    @order_items = OrderItem.all
    @total = 0
    @postage = 800
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
    @postage = 800
    if @order.customer_id != current_customer.id
      redirect_back(fallback_location: root_path)
      flash[:alert] = "アクセスに失敗しました。"
    end
  end

  def new

    @order_new = Order.new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
    @customer_shipping_addresses = @customer.addresses

  end

  def about
    @order = Order.new
    @order.order_items.build
    @total = 0
    @shipping_cost = 800
    @cart_items_customer = CartItem.where(customer_id: current_customer.id)
    @customer = Customer.find(params[:customer_id])
    @tax = 1.1

    @payment_method_enum = params[:payment_method]
    case @payment_method_enum
    when "0"
      @payment_method = "銀行振込"
    when "1"
      @payment_method = "クレジットカード"
    end

    @@button_selected = params[:selected]
    case @@button_selected
    when "a"
      @postal_code = params[:postal_code]
      @address = params[:address]
      @receiver = params[:name_family] + params[:name_first]
    when "b"
      if params[:address].blank?
        flash[:danger] = "お届け先が未入力です。"
        @customer_shipping_addresses = @customer.addresses
        render :new
      else
        shipping_address_id = params[:address]
        @postal_code = @customer.addresses.find(address_id).postal_code
        @address = @customer.addresses.find(ddress_id).address
        @receiver = @customer.addresses.find(address_id).receiver
      end
    when "c"
      if params[:p].blank? || params[:a].blank? || params[:r].blank?
        flash[:danger] = "お届け先が未入力です。"
        @customer_shipping_addresses = @customer.addresses
        render :new
      else
        @postal_code = params[:p]
        @address = params[:a]
        @receiver = params[:r]
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items_customer = current_customer.cart_items
    @tax = 1.1

    if @order.save
      @cart_items_customer.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.order_id = @order.id
        @order_item.item_id = cart_item.item.id
        @order_item.quantity = cart_item.quantity
        @order_item.tax_included_price = (cart_item.item.price * @tax).floor.to_s(:delimited)
        @order_item.production_status = 0

        @order_item.save
      end
      if @@button_selected == "c"
        @shipping_address = Address.new
        @shipping_address.customer_id = params[:customer_id]
        @shipping_address.postal_code = @order.postal_code
        @shipping_address.address = @order.address
        @shipping_address.receiver = @order.receiver
        @shipping_address.save
      end

      redirect_to customer_order_thanx_path
    else
      @customer = Cstomer.find(current_customer.id)
      @customer_shipping_addresses = @customer.addresses
      render :new
    end
  end

  def thanx

  end

  private
  def order_params
    params.require(:order).permit(:order_status, :postal_code, :receiver, :address, :postage, :payment_method, :total)
  end
end
