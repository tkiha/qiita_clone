class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    @stock = current_user.stocks.find_or_create_by!(item: @item)
  end

  def destroy
    current_user.stocks.find_by!(item: @item).destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
