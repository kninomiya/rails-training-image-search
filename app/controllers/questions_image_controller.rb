require 'google/cloud/storage'
require 'open-uri'

class QuestionsImageController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    logger.debug "images"
    images = params[:images]
    name = images[0]["id"]
    logger.debug "name"
    # url = params[:src]
    # open("https://support.sugutsukaeru.jp/ja/troubleshooting/installation/1/3-500-internal-server-error-is-a-black-box.png") { |image|
    open(images[0]["src"]) { |image|
      # File.open("test.jpg","wb") do |file|
      File.open(name+".jpg","wb") do |file|
        file.puts image.read
      end
    }
    storage = Google::Cloud::Storage.new(
        project_id: "polynomial-net-212709",
        credentials: "/Users/ninomiyakouichirou/RubymineProjects/key/My First Project-78cf42cd92b2.json"
    )

    # bucket名を入力
    bucket_name = "ninomiya_bucket"

    # bucketを指定
    bucket = storage.bucket bucket_name

  # def self.storage_bucket
  #   @storage_bucket ||= begin
  #     config = Rails.application.config.x.settings
  #     storage = Google::Cloud::Storage.new project_id: config["polynomial-net-212709"],
  #                                          credentials: config["/Users/ninomiyakouichirou/RubymineProjects/key/My First Project-78cf42cd92b2.json"]
  #     storage.bucket config["ninomiya_bucket"]
  #   end
  # end

    # bucket.create_file "/Users/ninomiyakouichirou/RubymineProjects/rails-training-image-search/rails-training-image-search/test.jpg",
    #                    "/screenshot/"+ name + ".png"
    # content_type: cover_image.content_type,
    # acl: "public"

  # after_create :upload_image, if: :cover_image

    bucket.create_file "/Users/ninomiyakouichirou/RubymineProjects/rails-training-image-search/rails-training-image-search/test.jpg",
                       "/screenshot/test.jpg",
    # content_type: cover_image.content_type,
    acl: "public"

    image_path = images[0]["src"]
    character = images[0]["id"]
    genre = 1

    # Resultsクラス(resultテーブル用のモデル)のcreateメソッドを実行・DB上のresultテーブルにレコードを新規登録
    question = Question.create({:image_path => image_path, :genre => genre, :character_string => character });

    respond_to do |format|
      format.json {
        render :json => { status: "ok", question: question.attributes }
      }
    end

    # bucket.create_file StringIO.new("Hello world!"), "hello-world2.txt"
  end
end
# ファイルを作成した上でアップロード
# bucket.create_file StringIO.new("Hello world!"), "hello-world.txt"

# 指定されたファイルのアップロード:ローカル:元ディレトトリ,アップロード先
# ※アップロード先を指定しないと元ディレクトリのパスのままフォルダが作成されてしまう
# bucket.create_file "/Users/ninomiyakouichirou/Desktop/screenshots/test.rtf"

# ネットワーク上からダウンロードしてきた場合は多分こっち？
#   bucket.create_file StringIO.new("Hello world!"), "hello-world.txt"

# file = bucket.file "/Users/ninomiyakouichirou/Desktop/screenshots/test.rtf"

# 前がファイル名の場所、後ろがアップロード先
# bucket = storage.bucket "ninomiya-attachments"
# bucket.create_file Images,"test.png"


# Download the file to the local file system
# file.download "/tasks/attachments/#{file.name}"

# Copy the file to a backup bucket
# backup = storage.bucket "task-attachment-backups"
# file.copy backup, file.name