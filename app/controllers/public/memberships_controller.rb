class Public::MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @family = Family.find(params[:family_id])
    membership = User.find(params[:user_id]).memberships.new(family_id: params[:family_id])
    membership.save
    redirect_to show_user_path(current_user), notice: "#{@family.name} へ参加申請をしました"
  end

  def destroy
    @family = Family.find(params[:family_id])
    membership = User.find(params[:user_id]).memberships.find_by(family_id: params[:family_id])
    if membership
      membership.destroy
      redirect_to show_user_path(current_user), alert: "#{@family.name} への参加申請を取消しました"
    else
      redirect_to show_user_path(current_user), alert: "メンバーシップが見つかりませんでした"
    end
  end

end