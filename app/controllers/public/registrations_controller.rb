# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]

  # POST /resource
  def create
    build_resource(sign_up_params.except(:family))
    family_name = sign_up_params[:family]

  # ファミリーを新規作成（所属グループが指定されている場合のみ）
      if family_name.present?
        @family = Family.create(name: family_name)

        # ファミリーをユーザーに関連付ける
        resource.family = @family
      end

    if resource.save
      # 保存成功時の処理
      set_flash_message! :notice, :signed_up
      sign_up(resource_name, resource)

      respond_to do |format|
        format.html { redirect_to after_sign_up_path_for(resource) }
      end
    else
      # 保存失敗時の処理
      logger.error(resource.errors.full_messages) # エラーメッセージをログに出力
      set_flash_message! :error, resource.errors.full_messages.join(', ')

      respond_to do |format|
        format.html { render :new }
      end
    end
  end

# ゲストログインユーザーを削除しないようにする
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
