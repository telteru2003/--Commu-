class Public::FamilyUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @family_user = FamilyUser.create(family_id: family_user_params[:family_id], user_id: family_user_params[:user_id])
    Membership.find(family_user_params[:membership_id]).destroy!
    redirect_to show_user_path(current_user), notice:"「#{@family_user.user.name}」が#{@family_user.family.name}へ加入しました"
  end

  def destroy
    @family_user = FamilyUser.find_by(family_id: params[:family_id], user_id: params[:user_id])

    if @family_user
      @family_user.destroy!
      @comminity = Family.find(params[:family_id])
      redirect_to show_user_path(current_user), notice: "「#{@comminity.name}」を退会しました"
    else
      # エラー処理などを行うか、リダイレクトなどを行って適切な対応をする
      redirect_to show_user_path(current_user), alert: "エラーが発生しました"
    end
  end

end
