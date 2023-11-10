class Public::UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def quit
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy!
    if @user.email == 'guest@example.com'
      # ゲストユーザーは退会させず、プロフィールを初期化
      @user.name = 'ゲストユーザー'
      @user.is_active = true
      @user.nickname = 'ゲスト'
      @user.image_id = nil
    else
      # 一般ユーザーは退会させる
      @user = User.find(params[:id])
      @user.update(is_active: false)
    end
    reset_session
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to root_path
  end

  def active_for_authentication?
    super && (is_valid == true)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email)
  end
end