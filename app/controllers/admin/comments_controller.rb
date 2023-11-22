class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.page(params[:page]).per(10) # 1ページあたりのコメント数を指定

    @comments = Comment.page(params[:page])
  end

  def destroy
    @food = Food.find(params[:food_id])
    if @comment.destroy!
      flash[:alert] = "食品情報が削除されました"
    else
      flash[:alert] = "指定された食品情報は存在しません"
    end
    redirect_to admin_comment_path(@comment)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
