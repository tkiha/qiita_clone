class Users::StocksController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @items = @user.items_stocked.recent.page(params[:page])
  end
end
