class Public::MembershipsController < ApplicationController

  def create
    @family = Family.find(params[:family_id])
    membership = User.find(params[:user_id]).memberships.new(family_id: params[:family_id])
    membership.save
    redirect_to request.referer, notice: "グループへ参加申請をしました"
  end

  def destroy
    @family = Family.find(params[:family_id])
    # membership = current_user.memberships.find_by(family_id: params[:family_id])
    membership = User.find(params[:user_id]).memberships.find_by(family_id: params[:family_id])


    if membership
      membership.destroy
      redirect_to request.referer, alert: "グループへの参加申請を取消しました"
    else
      # メンバーシップが見つからない場合の処理
      redirect_to family_path(@family), alert: "メンバーシップが見つかりませんでした"
    end

    # @membership = Membership.find(params[:id])
    # @membership.destroy!
    # @family = Family.find(params[:family_id])
    # redirect_to family_url(@family), notice: "加入申請を取り消しました"
  end

  # private

  # def membership_params
  #   params.permit(:family_id)
  # end

end