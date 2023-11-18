class Public::FamilyUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @family_user = FamilyUser.create(family_id: family_user_params[:family_id], user_id: family_user_params[:user_id])
    Membership.find(family_user_params[:membership_id]).destroy!
    redirect_to show_user_path(current_user), notice:"「#{@family_user.user.name}」が、コミュニティ：#{@family_user.family.name}へ加入しました。"

    # @family = Family.find(params[:family_id])
    # @membership = Membership.find(params[:membership_id])
    # @family_user = FamilyUser.create(user_id: @membership.user_id, family_id: params[:family_id])
    # @membership.destroy #参加希望者リストから削除する
    # redirect_to request.referer
  end

  def destroy
    @family_user = FamilyUser.find_by(family_id: params[:family_id], user_id: params[:user_id])
    @family_user.destroy!
    @comminity = Family.find(params[:family_id])
    redirect_to show_user_path(current_user), notice: "グループ「#{@comminity.name}」を退会しました。"

    # @family = Family.find(params[:family_id])
    # @membership = Membership.find(params[:membership_id])
    # @family_user = FamilyUser.find_by(user_id: @membership.user_id, family_id: params[:family_id])

    # if @family_user
    #   @family_user.destroy
    # end

    # redirect_to request.referer

  end

  private

  def family_user_params
    params.permit(:family_id, :user_id, :membership_id)
  end

end
