class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @latest_families = Family.order(created_at: :desc).limit(3)
    @latest_users = User.order(created_at: :desc).limit(3)
    @latest_foods = Food.order(created_at: :desc).limit(3)
    @latest_comments = Comment.order(created_at: :desc).limit(3)

    @all_families = Family.order(created_at: :desc)
    @all_users = User.order(created_at: :desc)
    @all_foods = Food.order(created_at: :desc)
    @all_comments = Comment.order(created_at: :desc)
  end
end
