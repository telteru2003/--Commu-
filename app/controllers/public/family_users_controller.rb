class Public::FamilyUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    family = Family.find(params[:family_id])
    membership = Membership.find(params[:membership_id])
    family_user = FamilyUser.create(user_id: membership.user_id, family_id: params[:family_id])
    membership.destroy
    redirect_to_family_with_notice("#{family_user.user.name} が #{family_user.family.name} へ加入しました")
  end

  def destroy
    family_user = FamilyUser.find_by(params[:id])
    if family_user
      family = family_user.family
      family_user.destroy!
      redirect_to_user_with_notice("ユーザーが #{family.name} から退会しました")
    else
      redirect_to_user_with_alert("エラーが発生しました")
    end
  end

  private

  def redirect_to_family_with_notice(notice)
    redirect_to family_path(current_user), notice: notice
  end

  def redirect_to_user_with_notice(notice)
    redirect_to show_user_path(current_user), notice: notice
  end

  def redirect_to_user_with_alert(alert)
    redirect_to show_user_path(current_user), alert: alert
  end
end
