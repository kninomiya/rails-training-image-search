require Rails.root.join("app/models/cse.rb")
require 'google/cloud/vision'
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
    vision = Google::Cloud::Vision.new(
        project_id: "polynomial-net-212709",
        credentials: "/Users/ninomiyakouichirou/RubymineProjects/key/Project-9d62f14f14ed.json"
    )

    # キーワードに関連する画像を検索
    result = image_search_client.findBy(@keyword)
    @images = JSON.generate(result[:images])
    @count = result[:count];
    count = result[:count];

    i = result[:count]
    logger.debug "Parameter"

    count.times do |i|
      file_name = result[:images][i][:src]

      logger.debug file_name

      # Performs label detection on the image file
      labels = vision.image(file_name).labels

      puts "Labels:"
      labels.each do |label|
      puts label.description
      puts label
      if label.score > 0.7 then
        p "ok"
      end
      end
    end




    # count.times do |i|
    #   file_name = images[i]["src"]
    #   # Performs label detection on the image file
    #   labels = vision.image(file_name).labels
    #   logger.debug "gazou"
    #   labels.each do |label|
    #     puts "Labels:"
    #     puts label.description
    #     puts label
    #     if label.score > 0.7 then
    #       p "ok"
    #     end
    #   end
    # end



    # 先頭１件の画像URLを出力
    respond_to do |format|
      format.html
      format.json { render :json => result }
    end
  end
  def create
  end
end