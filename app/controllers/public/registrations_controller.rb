class Public::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :ensure_normal_user, only: %i[update destroy]

  def create
    build_resource(sign_up_params.except(:family))
    family_name = sign_up_params[:family]

    if resource.save
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)
      respond_to do |format|
        format.html { redirect_to after_sign_up_path_for(resource) }
      end
    else
      logger.error(resource.errors.full_messages)
      set_flash_message! :error, resource.errors.full_messages.join(', ')
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :family)
  end

  def after_sign_up_path_for(resource)
    flash[:notice] = "ユーザー登録が完了しました"
    foods_path
  end

  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :nickname, :family)
  end
end
