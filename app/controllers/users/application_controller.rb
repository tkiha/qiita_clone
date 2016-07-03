class Users::ApplicationController < ApplicationController
  private

  def set_user
    @user = User.find(params[:user_id])
  end
end

