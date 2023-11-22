class Admin::SearchController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == 'family'
      @records = Family.search_for(@content,@method)
    elsif @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'food'
      @records = Food.search_for(@content, @method)
    elsif @model == 'comment'
      @records = Comment.search_for(@content, @method)
    end
  end
end
