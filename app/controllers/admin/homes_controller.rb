class Admin::HomesController < ApplicationController
  def top
    @daily_order_counts = Order.where(created_at: Time.current.all_day)
  end
  
end
