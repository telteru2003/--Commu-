class Public::FamilyUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @family = Family.find(params[:family_id])
    @membership = Membership.find(params[:membership_id])
    @family_user = FamilyUser.create(user_id: @membership.user_id, family_id: params[:family_id])
    @membership.destroy #参加希望者リストから削除する
    redirect_to request.referer
  end

  def destroy
    @family = Family.find(params[:family_id])
    @membership = Membership.find(params[:membership_id])
    @family_user = FamilyUser.find_by(user_id: @membership.user_id, family_id: params[:family_id])

    if @family_user
      @family_user.destroy
    end

    redirect_to request.referer
  end
end
