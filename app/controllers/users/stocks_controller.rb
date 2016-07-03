class Users::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @items = @user.items_stocked.recent.page(params[:page])
  end

  private

  def set_user
    @user = User.find params[:user_id]
  end
end
