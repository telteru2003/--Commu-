class Public::FamiliesController < ApplicationController

  def new
    @user = current_user
    @family = Family.new
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

  def create
    @family = Family.new(family_params)
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

  private

  def family_params
    params.require(:family).permit(:name)
  end

end
