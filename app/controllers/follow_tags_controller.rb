class FollowTagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag

  def create
    current_user.follow_tag @tag
  end

  def destroy
    current_user.unfollow_tag @tag
  end

  private

  def set_tag
    @tag = Tag.find(params[:tag_id])
  end
end
