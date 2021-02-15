class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!
  @@button_selected = ""

  def index
    @orders = current_customer.orders.page(params[:page]).reverse_order
    @order_items = OrderItem.all
    @total_payment = 0
    @postage = 800
  end

  def show
   @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total_payment = 0
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
    @total_payment = 0
    @shipping_cost = 800
    @cart_items_customer = CartItem.where(customer_id: current_customer.id)
    @customer = current_customer
    @tax = 1.1

    @settlement_enum = params[:settlement]
    case @settlement_enum
    when "0"
      @settlement = "銀行振込"
    when "1"
      @settlement = "クレジットカード"
    end

    @@button_selected = params[:selected]
    case @@button_selected
    when "a"
      @postal_code = params[:postal_code]
      @address = params[:address]
      @name = params[:last_name] + params[:first_name]
    when "b"
      if params[:address].blank?
        flash[:danger] = "お届け先が未入力です。"
        @customer_shipping_addresses = @customer.addresses
        render :new
      else
        @shipping_address_id = params[:address]
        @postal_code = @customer.addresses.find(address_id).postal_code
        @address = @customer.addresses.find(address_id).address
        @name = @customer.addresses.find(address_id).name
      end
    when "c"
      if params[:p].blank? || params[:a].blank? || params[:r].blank?
        flash[:danger] = "お届け先が未入力です。"
        @customer_shipping_addresses = @customer.addresses
        render :new
      else
        @postal_code = params[:p]
        @address = params[:a]
        @name = params[:r]
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
        @order_item.amount = cart_item.amount
        @order_item.price = (cart_item.item.price * @tax).floor.to_s(:delimited)
        @order_item.production_status = 0

        @order_item.save
      end
      if @@button_selected == "c"
        @shipping_address = Address.new
        @shipping_address.customer_id = params[:customer_id]
        @shipping_address.postal_code = @order.postal_code
        @shipping_address.name = @order.name
        @shipping_address.save
      end

      redirect_to thanx_path
    else
      @customer = current_customer
      @customer_shipping_addresses = @customer.addresses
      render :new
    end
  end

  def thanx

  end

  private
  def order_params
    params.require(:order).permit(:order_status, :postal_code, :name, :address, :postage, :settlement, :total_payment)
  end

end
