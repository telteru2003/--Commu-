class Public::FoodsController < ApplicationController
  before_action :set_user

  def index
    family = current_user.family || current_user.family_users.first&.family
    if family.present?
      user_ids = family.users.pluck(:id) << family.owner.id
      @foods = Food.includes(:place, :user).where(user_id: user_ids)
    else
      @foods = current_user.foods.includes(:place)
    end
  end

  def new
    family = current_user.family || current_user.family_users.first&.family
    if family.present?
      user_ids = family.users.pluck(:id) << family.owner.id
      @places = family.places
      @food = @user.foods.new
    else
      @foods = current_user.foods.includes(:place)
    end
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
    family = current_user.family || current_user.family_users.first&.family
    if family.present?
      user_ids = family.users.pluck(:id) << family.owner.id
      @places = family.places
      @food = Food.find(params[:id])
    else
      @foods = current_user.foods.includes(:place)
    end
  end

  def edit
    family = current_user.family || current_user.family_users.first&.family
    if family.present?
      user_ids = family.users.pluck(:id) << family.owner.id
      @places = family.places
      @food = Food.find(params[:id])
    else
      @foods = current_user.foods.includes(:place)
    end
  end

  def update
    @food = Food.find(params[:id])
      if @food && @food.update(food_params) # @foodがnilでないことを確認し、updateが成功したかどうかを確認
        flash[:notice] = "食品類情報を更新しました"
        redirect_to foods_path
      else
        flash[:alert] = "エラーにより食品情報を更新できません"
        render :edit
      end
  end

  private

  def set_user
    @user = current_user
  end

  def food_params
    params.require(:food).permit(:name, :expiration_date, :jan_code, :image, :genre, :place_id, :consume_status)
  end

end
