class Admin::OrderedProductsController < ApplicationController

  def update
  @order = Order.find(params[:order_item][:order_id])
  @order_item = OrderItem.find(params[:id])
  @order_item.update(order_item_params)
    if params[:order_item][:production_status] == "製作中"
      @order.order_status = "製作中"
      @order.save(order_item_params)

    elsif params[:order_item][:production_status] == "製作完了"

      @production = @order.order_items.where.not(production_status: "製作完了")

       if !@production.any?
        @order.order_status = "発送準備中"
        @order.save(order_item_params)
       end
    end

   flash[:success] = "製作ステータスを更新しました！"
  redirect_to request.referer
  end

  private
  def order_item_params
  params.require(:order_item).permit(:order_id, :item_id, :amount, :price, :production_status,
    order_attributes: [:customer_id, :order_status, :postal_code,:name, :address, :postage, :settlement,
     :total_payment, :created_at, :updated_at],
     customers_attributes: [:last_name, :first_name ])
  end

end
