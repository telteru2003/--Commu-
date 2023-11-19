class Public::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーはこのページにアクセスできません'
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to show_user_path(@user)
    else
      flash[:alert] = "エラーによりユーザー情報を更新できません"
      render :edit
    end
  end

  def quit
    @user = current_user
  end

  def destroy
    @user = current_user
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

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :profile_image, :family_id)
  end
end