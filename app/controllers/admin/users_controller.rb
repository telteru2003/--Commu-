class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:update]

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def update
    # is_active フラグを反転
    @user.update(is_active: !@user.is_active)

    if @user.save
      flash[:notice] = "ユーザー情報が更新されました"
    else
      flash[:alert] = "ユーザー情報の更新に失敗しました"
    end

    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :remember_token, :is_active)
  end
end
