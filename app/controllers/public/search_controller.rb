class Public::SearchController < ApplicationController
  before_action :set_user

  def search
    @content = params[:content]
    @method = params[:method]
    @records = Family.search_for(@content, @method)
  end

  private

  def set_user
    @user = current_user
  end

end
