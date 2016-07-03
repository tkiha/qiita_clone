class Tags::ApplicationController < ApplicationController
  private

  def set_tag
    @tag = Tag.find(params[:tag_id])
  end
end

