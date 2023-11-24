class Admin::SearchController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    # ポリモーフィックな検索を行う
    @records = perform_search(@model, @content, @method).page(params[:page]).per(10)
  end

  private

  def perform_search(model, content, method)
    # 対応するモデルを取得
    searchable_model = model.capitalize.constantize

    # ポリモーフィックな検索を実行
    searchable_model.search_for(content, method)
  end
end