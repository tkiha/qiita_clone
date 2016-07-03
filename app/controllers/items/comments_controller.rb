class Items::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @item = Item.find(params[:item_id])
    @comment.item = @item

    if @comment.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render @item
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
