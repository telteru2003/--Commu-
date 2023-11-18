class Public::FoodsController < ApplicationController
  before_action :set_user

  def index
    @foods = Food.all
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
