class Public::HomesController < ApplicationController
  def top
    @items = Item.where(is_sale_status: true)
    @genres = Genre.where(is_invalid_flag: true).page(params[:page]).per(5)
  end

  def about
    
  end
  
  def redirect
    @id = params[:customer_id]
  end

end
