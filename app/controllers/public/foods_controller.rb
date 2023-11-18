class Public::FoodsController < ApplicationController
  before_action :set_user

  def index
    if current_user.family.present?
      family = current_user.family
      users = family.users.pluck(:id)
      owner = family.owner.id
      users.push(owner)
      @foods = Food.where(user_id: users)
    elsif current_user.family_users.first.present?
      family = current_user.family_users.first.family
      users = family.users.pluck(:id)
      owner = family.owner.id
      users.push(owner)
      @foods = Food.where(user_id: users)
    else
      @foods = current_user.foods
    end
  end

  def new
    @food = @user.foods.new
  end

  def create
    @food = @user.foods.new(food_params)
    if @food.save
      redirect_to foods_path, notice: '食品が投稿されました。'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = current_user
  end

  def food_params
    params.require(:food).permit(:name, :expiration_date, :jan_code, :family_id, :image, :genre_id, :place_id, :consume_status, :image) #.tap do |whitelisted|
    #   whitelisted[:consume_status] = params[:food][:consume_status].to_i
    # end
  end

end
