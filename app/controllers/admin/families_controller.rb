class Admin::FamiliesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_family, only: [:show, :edit, :destroy]

  def index
    @families = Families.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def destroy
    if @family.destroy!
      flash[:alert] = "食品情報が削除されました"
    else
      flash[:alert] = "指定された食品情報は存在しません"
    end
    redirect_to admin_family_path(@family)
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :owner_id)
  end

end
