class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i(edit update destroy)
  before_action :set_user, only: %i(show edit update destroy)
  before_action :correct_user_set_user, only: %i(edit update destroy)

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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user_set_user
    unless current_user == @user
      flash[:danger] = "権限がありません。"
      redirect_to root_url
    end
  end
end

