class Items::ApplicationController < ApplicationController
  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end

