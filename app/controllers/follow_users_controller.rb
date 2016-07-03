class FollowUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow @user
    render js: 'location.reload();'
  end

  def destroy
    current_user.unfollow @user
    render js: 'location.reload();'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
