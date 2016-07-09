class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def authenticate_user!
    unless logged_in?
      redirect_to login_url, flash: { warning: 'ログインしてください。' }
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end

