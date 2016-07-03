class Users::FollowTagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(index)

  def index
    @tags = @user.tags_followed.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
