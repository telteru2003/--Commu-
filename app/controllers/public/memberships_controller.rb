class Public::MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @family = Family.find(params[:family_id])
    membership = current_user.memberships.new(family_id: params[:family_id])
    membership.save
    redirect_to request.referer, notice: "グループへ参加申請をしました"
  end

  def destroy
    membership = current_user.memberships.find_by(family_id: params[:family_id])
    membership.destroy
    redirect_to request.referer, alert: "グループへの参加申請を取消しました"
  end

end
