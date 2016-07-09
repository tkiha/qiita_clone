class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.item = @item

    if @comment.save
      redirect_to @item, flash: { info: 'コメントが投稿されました。' }
    else
      render @item
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
