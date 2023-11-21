class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @food = Food.find(params[:food_id])
    @like = current_user.likes.build(food: @food)

    if @like.save
      redirect_to foods_path, notice: 'いいねしました'
    else
      redirect_to foods_path, alert: 'いいねできませんでした'
    end
  end

  def destroy
    @food = Food.find(params[:food_id])
    @like = current_user.likes.find_by(food: @food)

    if @like.destroy
      redirect_to foods_path, notice: 'いいねを取り消しました'
    else
      redirect_to foods_path, alert: 'いいねの取り消しができませんでした'
    end
  end
end
