class Public::FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :memberships]

  def new
    @user = current_user
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @family.owner_id = current_user.id
    @user = current_user

    if @family.save
      @user.family = @family
      @user.save
      flash[:notice] = "グループを作成しました"
      redirect_to show_user_path(@user)
    else
      flash[:notice] = "エラーによりグループを作成できません"
      render 'new'
    end
  end

  def show
    @family = Family.find(params[:id])
    @users = @family.users
    @user = current_user
  end

  def edit
    @family = Family.find(params[:id])
    @user = current_user
  end

  def invite
    @family = Family.find(params[:id])
    @user = current_user
  end

  def update
    @family = Family.find(params[:id])
    @user = current_user

    if @family.update(family_params)
      flash[:notice] = "グループ情報を更新しました"
      redirect_to family_path(@family)
    else
      flash[:notice] = "エラーによりグループ情報を更新できません"
      render :edit
    end
  end

  def memberships
    @family = Family.find(params[:id])
    @memberships = @family.permits.page(params[:page])
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end

  # params[:id]を持つ@familyのowner_idカラムのデータと自分のユーザーIDが一緒かどうかを確かめる。
  # 違う場合、処理をする。グループ一覧ページへ遷移させる。before_actionで使用する。
  def ensure_correct_user
    @family = Family.find(params[:id])
    unless @family.owner_id == current_user.id
      redirect_to families_path(@family), alert: "グループオーナーのみ編集が可能です"
    end
  end
end
