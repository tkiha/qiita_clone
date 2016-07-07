class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(edit update destroy)
  before_action :set_user, only: %i(show edit update destroy items stocks tags followers following)
  before_action :require_same_user, only: %i(edit update destroy)

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def items
    @items = @user.items.recent.page(params[:page])
  end

  def stocks
    @items = @user.items_stocked.recent.page(params[:page])
  end

  def tags
    @tags = @user.tags_followed.page(params[:page])
  end

  def followers
    @followers = @user.followers.page(params[:page])
  end

  def following
    @following = @user.following.page(params[:page])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_same_user
    unless current_user == @user
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end

