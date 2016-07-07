class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    current_user.stock @item
  end

  def destroy
    current_user.unstock @item
  end
end
