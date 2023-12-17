class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food_and_comment, only: [:create, :destroy]

  def index
    @comments = Comment.page(params[:page]).per(10)
  end

  def create
    if @comment.save
      redirect_to_food_with_notice('コメントが投稿されました')
    else
      redirect_to_food_with_alert('コメントの投稿に失敗しました')
    end
  end

  def destroy
    if @comment
      @comment.destroy!
      redirect_to_food_with_notice('コメントは正常に削除されました')
    else
      redirect_to_food_with_alert('コメントの削除に失敗しました')
    end
  end

  private

  def set_food_and_comment
    @food = Food.find(params[:food_id])
    @comment = params[:action] == 'create' ? build_comment : Comment.find_by(id: params[:id])
    @comments = @food.comments.reload if @comment.persisted?
  end

  def build_comment
    @food.comments.build(comment_params.merge(user_id: current_user.id))
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def redirect_to_food_with_notice(notice)
    redirect_to food_path(@food), notice: notice
  end

  def redirect_to_food_with_alert(alert)
    redirect_to food_path(@food), alert: alert
  end
end
