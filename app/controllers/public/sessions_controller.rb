class Public::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)

    if resource
      resource.generate_and_save_remember_token
    else
      redirect_to root_path
    end
  end

  # ゲストログイン
  def guest_sign_in
    user = User.guest_login
    sign_in user
    flash[:notice] = 'ゲストユーザーとしてログインしました'
    redirect_to foods_path
  end

  protected

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    puts "User #{resource.email} signed in at #{Time.now}"
    foods_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
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
