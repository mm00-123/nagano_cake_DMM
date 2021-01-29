class Admin::OrderedProductsController < ApplicationController
  
  def update
  @order = Order.find(params[:order_item][:order_id])
  @order_item = OrderItem.find(params[:id])
  @order_item.update(order_item_params)
    if params[:order_item][:production_status] == "製作中"
      @order.order_status = "製作中"
      @order.save(order_item_params)

    elsif params[:order_item][:production_status] == "製作完了"
 # 製作完了じゃないデータを取り出す
      @production = @order.order_items.where.not(production_status: "製作完了")
     # 製作完了のデータのみだったら
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
  #   params.require(:order_item).permit(:production_status)
  # end
  params.require(:order_item).permit(:order_id, :item_id, :quantity, :tax_inculuded_price, :production_status,
    order_attributes: [:customer_id, :order_status, :postal_code,:receiver, :address, :postage, :payment_method,
     :total, :created_at, :updated_at],
     members_attributes: [:name_family, :name_first ])
  end
  
end
