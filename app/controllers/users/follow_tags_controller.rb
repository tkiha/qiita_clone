class Users::FollowTagsController < Users::ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(index)

  def index
    @tags = @user.tags_followed.page(params[:page])
  end
end
