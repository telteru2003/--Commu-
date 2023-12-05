class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @comments = Comment.page(params[:page]).per(10)
  end

  def create
    @food = Food.find(params[:food_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.food_id = @food.id # コメントを特定の食品に関連づける
    if @comment.body.present?  # コメントが空でないかを確認
      if @comment.save  # コメントが正常に保存されたら、コメント一覧を取得
        @comments = @food.comments.reload
        redirect_to food_path(@food), notice: 'コメントが投稿されました'
      else  # 保存に失敗した場合の処理
        redirect_to food_path(@food), alert: 'コメントの投稿に失敗しました'
      end
    else  # コメントが空の場合の処理
      redirect_to food_path(@food), alert: 'コメントは空欄では投稿できません'
    end
  end

  def destroy
    @food = Food.find(params[:food_id])
    @comment = Comment.find_by(id: params[:id])
    if @comment
      @food = @comment.food
      @comment.destroy!
      flash[:notice] = "コメントは正常に削除されました"
      redirect_to food_path(@food)
    else
      flash[:alert] = "コメントの削除に失敗しました"
      redirect_to food_path(@food)
    end
  end


  private

  def set_user
    @user = current_user
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
