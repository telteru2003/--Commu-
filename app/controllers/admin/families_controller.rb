class Admin::FamiliesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_family, only: [:destroy]

  def index
    @families = Family.page(params[:page]).per(10)
  end

  def destroy
    if @family.destroy!
      flash[:alert] = "グループが削除されました"
    else
      flash[:alert] = "エラーにより削除できません"
    end
    redirect_to admin_family_path
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name, :owner_id)
  end

end
