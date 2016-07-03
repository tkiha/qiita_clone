class Users::StocksController < Users::ApplicationController
  before_action :set_user

  def index
    @items = @user.items_stocked.recent.page(params[:page])
  end
end
