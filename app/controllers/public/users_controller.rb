class Public::UsersController < ApplicationController
  before_action :set_family
  before_action :set_user, only: [:edit, :update, :quit, :destroy]

  def index
    @users = User.all
  end

  def show
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーはこのページにアクセスできません'
    else
      @user = User.find(params[:id])
      @is_entry_membership = Membership.find_by(user_id: @user.id)
      @is_entry_family_user = FamilyUser.find_by(user_id: @user.id)
    end
      @likes = Like.page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to show_user_path(@user)
    else
      flash[:alert] = "エラーによりユーザー情報を更新できません"
      render :edit
    end
  end

  def quit
  end

  def destroy
    if @user.email == 'guest@example.com'
      @user.name = 'ゲストユーザー'
      @user.is_active = true
      @user.nickname = 'ゲスト'
      @user.image_id = nil
      @user.save
    else
      sign_out(@user)
      @user.destroy!
    end

    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to root_path
  end

  def active_for_authentication?
    super && (is_valid == true)
  end

  def search_family
    search_term = params[:family_search]
    families = Family.where("name LIKE ? OR id = ?", "%#{search_term}%", search_term.to_i)
    render json: families
  end

  private

  def set_family
    @family = Family.find_by(params[:id])
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :profile_image, :family_id)
  end
end