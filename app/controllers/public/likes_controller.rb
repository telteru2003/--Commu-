class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @food = Food.find(params[:food_id])
    @like = current_user.likes.build(food: @food)

    if @like.save
      respond_to do |format|
        format.html { redirect_to foods_path, notice: "#{@food.name}をいいねしました" }
        format.json { render json: { count: @food.likes_count } }
      end
    else
      respond_to do |format|
        format.html { redirect_to foods_path, alert: "#{@food.name}をいいねできませんでした" }
        format.json { render json: { error: 'いいねできませんでした' }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food = Food.find(params[:food_id])
    @like = current_user.likes.find_by(food: @food)

    if @like.destroy
      respond_to do |format|
        format.html { redirect_to foods_path, notice: "#{@food.name}のいいねを取り消しました" }
        format.json { render json: { count: @food.likes_count } }
      end
    else
      respond_to do |format|
        format.html { redirect_to foods_path, alert: "#{@food.name}のいいねの取り消しができませんでした" }
        format.json { render json: { error: 'いいねの取り消しができませんでした' }, status: :unprocessable_entity }
      end
    end
  end
end
