class Users::FollowUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow @user
  end

  def destroy
    current_user.unfollow @user
  end

  def followers
    @followers = @user.followers.page(params[:page])
  end

  def following
    @following = @user.following.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
