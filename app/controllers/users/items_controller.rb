class Users::ItemsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @items = @user.items.recent.page(params[:page])
  end
end
