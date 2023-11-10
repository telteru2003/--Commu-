class Public::SessionsController < Devise::SessionsController

  def create
    super do |resource|
      resource.generate_remember_token # ログイン時にremember_tokenを生成
    end
  end

  # ゲストログイン
  def guest_sign_in
    user = User.guest_login
    sign_in user
    flash[:notice__upper] = 'ゲストユーザーとしてログインしました'
    redirect_to show_user_path(id: user.id)
  end

  protected

  def after_sign_in_path_for(resource)
    foods_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"  # flashメッセージの追加もできます
    root_path
  end

  def reject_user
    @user = User.find(params[:id])
      if @user
        if @user.valid_password?(params[:user][:password]) &&  (@user.active_for_authentication? == true)
        redirect_to new_user_registration
        end
      end
  end

end
