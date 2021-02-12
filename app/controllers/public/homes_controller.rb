class Public::HomesController < ApplicationController
  def top
    @items = Item.where(is_sale_status: true)
  end

  def about

  end

  def redirect
    @id = params[:customer_id]
  end

end
