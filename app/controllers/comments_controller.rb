class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @item = Item.find(params[:item_id])
    @comment.item = @item

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
      else
        format.html { render @item }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
