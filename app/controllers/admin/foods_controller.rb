class Admin::FoodsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_food, only: [:destroy]

  def index
    @foods = Food.all.page(params[:page]).per(10)
    @all_foods = Food.order(created_at: :desc)
  end

  def destroy
    if @food.destroy!
      flash[:alert] = "食品情報が削除されました"
    else
      flash[:alert] = "食品情報の削除に失敗しました"
    end
    redirect_to admin_foods_path
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :genre, :expiration_date, :jan_code, :consume_status)
  end

end
