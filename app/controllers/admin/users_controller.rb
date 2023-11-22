class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :destroy]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def destroy
    if @user.destroy!
      flash[:alert] = "食品情報が削除されました"
    else
      flash[:alert] = "指定された食品情報は存在しません"
    end
    redirect_to admin_family_path(@family)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :remember_token, :is_active)
  end

end
