class TagsController < ApplicationController
  def show
    @tag = Tag.find params[:id]
    @items = @tag.items.includes(:user, :tags).published.recent.page(params[:page])
  end
end
