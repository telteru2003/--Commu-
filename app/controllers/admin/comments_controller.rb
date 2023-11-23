class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_comment, only: [:destroy]

  def index
    @comments = Comment.all.page(params[:page]).per(10)
    @all_comments = Comment.order(created_at: :desc)
  end

  def destroy
    if @comment.destroy!
      flash[:alert] = "コメントが削除されました"
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
    redirect_to admin_comments_path
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
