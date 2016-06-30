class Users::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def index
    @items = @user.items_stocked.recent
  end

  private

  def correct_user
    @user = User.find params[:user_id]
    unless @user == current_user
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end
