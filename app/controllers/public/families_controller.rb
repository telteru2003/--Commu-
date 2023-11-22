class Public::FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: [:show, :edit, :update, :permit, :destroy]

  def new
    @family = Family.new
  end

  def create
    @user = current_user
    @family = Family.new(family_params)
    @family.owner_id = current_user.id

    if @family.save
      @user.family = @family
      @user.save
      flash[:notice] = "グループを作成しました"
      redirect_to show_user_path(@user)
    else
      flash[:alert] = "エラーによりグループを作成できません"
      render 'new'
    end
  end

  def show
    @users = @family.users
    @owner = @family.owner
  end

  def edit
    @family.places.build # 新しい保管場所のフォームを表示するために追加
    @places = Place.all
    @place = Place.new
  end

  def update
    if @family.update(family_params)
      flash[:notice] = "グループ情報を更新しました"
      redirect_to family_path(@family)
    else
      flash[:alert] = "エラーによりグループ情報を更新できません"
      render :edit
    end
  end

  def destroy
    @family.destroy!
    flash[:notice] = 'グループを削除しました'
    redirect_to user_path(@user)
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :owner_id)
  end

end
