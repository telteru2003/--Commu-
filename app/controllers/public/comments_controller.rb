class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.page(params[:page]).per(10)
  end

  def create
    @food = Food.find(params[:food_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.food_id = @food.id # コメントを特定の食品に関連づける
    if @comment.save
      # コメントが正常に保存されたら、コメント一覧を取得
      @comments = @food.comments.reload
      redirect_to food_path(@food), notice: 'コメントが投稿されました'
    else
      # 保存に失敗した場合の処理
      redirect_to food_path(@food), alert: 'コメントの投稿に失敗しました'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
