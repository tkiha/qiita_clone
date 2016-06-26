class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :correct_user_set_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.all
  end

  def show
    @comment = Comment.new
    if logged_in?
      @stock = current_user.stocks.find_by(item: @item)
    end
  end

  def new
    @item = current_user.items.build
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def correct_user_set_item
      @item = current_user.items.find(params[:id])
      if @item.nil?
        flash[:danger] = "権限がありません。"
        redirect_to :back
      end
    end

    def item_params
      params.require(:item).permit(:title, :content)
    end
end

