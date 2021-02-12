class Admin::ItemsController < ApplicationController

  def new
    @item_new = Item.new
    @genres = Genre.all
  end

  def create
    @item_new = Item.new(item_params)
    if @item_new.save
      redirect_to admin_item_path(@item_new)
    else
      @genres = Genre.all
      render :new
    end
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
    @item_tax_included_price = (@item.price * 1.1).floor

  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all

  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      @genres = Genre.all
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :image, :price, :is_active)
  end


end
