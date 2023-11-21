class Public::FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    set_foods_and_places
    if params[:place_id].present?
      @foods = @foods.where(place_id: params[:place_id])
    end
    if params[:genre].present?
      @foods = @foods.where(genre: params[:genre])
    end
    if params[:consume_status].present?
      @foods = @foods.where(consume_status: params[:consume_status])
    end
    if params[:sort_by_expiration_date].present?
      sort_direction = params[:sort_by_expiration_date] == "desc" ? "DESC" : "ASC"
      @foods = @foods.order("expiration_date #{sort_direction}")
    end
    @foods = @foods.includes(:likes)
  end

  def new
    set_foods_and_places
    @food = @user.foods.new
  end

  def create
    @food = @user.foods.new(food_params)
    if @food.save
      redirect_to foods_path, notice: '食品類が投稿されました'
    else
      render :new
    end
  end

  def show
    set_food_and_places
  end

  def edit
    set_food_and_places
  end

  def update
    @food = Food.find(params[:id])
    if @food && @food.update(food_params)
      flash[:notice] = "食品類情報を更新しました"
      redirect_to foods_path
    else
      flash[:alert] = "エラーにより食品情報を更新できません"
      render :edit
    end
  end

def destroy
  @user = current_user
  @food = Food.find(params[:id])

  if @food
    @food.destroy!
    flash[:alert] = "食品情報が削除されました"
  else
    flash[:alert] = "指定された食品情報は存在しません"
  end
  redirect_to foods_path
end

  private

  def set_user
    @user = current_user
  end

  def set_foods_and_places
    family = @user.family || @user.family_users.first&.family
    if family.present?
      user_ids = family.users.pluck(:id) << family.owner.id
      @foods = Food.includes(:place, :user, :likes).where(user_id: user_ids)
      @places = family.places
    else
      @foods = @user.foods.includes(:place, :likes)
    end
  end

  def set_food_and_places
    set_foods_and_places
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :expiration_date, :jan_code, :image, :genre, :place_id, :consume_status)
  end
end
