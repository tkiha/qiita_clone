class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_item, only: %i(show edit update destroy)
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.recent.page(params[:page])
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

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def correct_user
    unless @item.user == current_user
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end

  def item_params
    params.require(:item).permit(:title, :content, tags_attributes: [:name])
  end
end
