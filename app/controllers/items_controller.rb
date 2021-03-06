class ItemsController < ApplicationController
  # 細かいですが、配列の記法が統一されていないのが気になりました。（%iで書くことが多いと思います）
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_item, only: %i(show edit update destroy)
  before_action :require_my_item, only: [:edit, :update, :destroy]
  before_action :require_item_published, only: %i(show)

  def index
    # .all無しでもいけますね
    @items = Item.recent.published.includes(:user, :tags).page(params[:page])
  end

  def show
    @comment = Comment.new
  end

  def new
    @item = current_user.items.build
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)
    @item.published_at = Time.now if @item.published?
    if @item.save
      redirect_to @item, flash: { success: '記事が投稿されました。' }
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, flash: { success: '記事が編集されました。' }
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, flash: { success: '記事が削除されました。' }
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def require_my_item
    unless @item.user == current_user
      redirect_to root_url, flash: { danger: '権限がありません。' }
    end
  end

  def require_item_published
    unless @item.published?
      require_my_item
    end
  end

  def item_params
    params.require(:item).permit(:title, :content, :aasm_state, :tags)
  end
end
