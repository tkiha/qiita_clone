class Users::StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.items_stocked
  end
end
