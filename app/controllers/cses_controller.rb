require Rails.root.join("app/models/cse.rb")
require 'json'

class CsesController < ApplicationController
  def index
  end

  def show
    @keyword = params[:keyword]
    image_search_client = LessonImageSearchClient.new(
        ENV["GAPI_CUSTOMSEARCH_APIKEY"],
        ENV["GAPI_CUSTOMSEARCH_CX"]
    )

    # キーワードに関連する画像を検索
    result = image_search_client.findBy(@keyword)
    @images = JSON.generate(result[:images])
    @count = result[:count];

    # 先頭１件の画像URLを出力
    respond_to do |format|
      format.html
      format.json { render :json => result }
    end
  end
  def create
  end
end