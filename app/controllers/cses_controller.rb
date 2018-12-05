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
    i = 0
    flag = ["OK","OK","NG","NG","OK","NG","NG","NG","OK","OK"];

    count.times do |i|
      logger.debug i
      # open(result[:images][i][:src]) { |image|
      open(result[:images][i][:src]) { |image|
        File.open("test.jpg","wb") do |file|
          file.puts image.read
        end
      }
      file_name = "/Users/ninomiyakouichirou/RubymineProjects/rails-training-image-search/rails-training-image-search/test.jpg"
      # Performs label detection on the image file
      labels = vision.image(file_name).labels
      puts "Labels:"
      # flag[i] = "NG"
      puts result[:images][i]
      labels.each do |label|
      puts label.description
      puts label

      if label.description == "dog" then
        p "OK"
        result[:images][i][:flag] = "OK"
        # flag[i] = "OK"
      else
        # result[:images][i] < "NG"
        result[:images][i][:flag] = "NG"
        p "NG"
      end
      end
    end
    logger.debug result[:images]
    # logger.debug 123456--

    # 先頭１件の画像URLを出力
    respond_to do |format|
      format.html
      format.json { render :json => result }
    end
  end
  def create
  end
end