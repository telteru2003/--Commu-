class Admin::FoodController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_food, only: [:show, :edit, :destroy]

  def index
    @foods = Food.page(params[:page]).per(10)
    @food = Food.all
    @genres = Genre.all
  end

  def show
  end

  def edit
  end

  def destroy
    if @food.destroy!
      flash[:alert] = "食品情報が削除されました"
    else
      flash[:alert] = "指定された食品情報は存在しません"
    end
    redirect_to admin_family_path(@family)
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :genre, :expiration_date, :jan_code, :consume_status)
  end

end
