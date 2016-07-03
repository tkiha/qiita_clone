class Users::ItemsController < Users::ApplicationController
  before_action :set_user

  def index
    @items = @user.items.recent.page(params[:page])
  end
end
