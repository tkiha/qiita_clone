class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def authenticate_user!
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
end

