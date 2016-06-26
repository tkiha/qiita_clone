class StocksController < ApplicationController
  before_action :set_item

  def create
    current_user.stocks.find_or_create_by!(item: @item)
    render js: 'location.reload();'
  end

  def destroy
    stock = current_user.stocks.find_by!(item: @item)
    stock.destroy
    render js: 'location.reload();'
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
