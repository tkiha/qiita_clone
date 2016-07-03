class HomeController < ApplicationController
  before_action :set_feed

  def index
  end

  private

  def set_feed
    if logged_in?
      @feed = current_user.feed_items.page(params[:page])
    end
  end
end

