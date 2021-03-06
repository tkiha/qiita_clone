class FollowUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow @user
  end

  def destroy
    current_user.unfollow @user
  end
end
