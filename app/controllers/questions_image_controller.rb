require 'google/cloud/storage'
require 'google/cloud/vision'
require 'open-uri'

class QuestionsImageController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    vision = Google::Cloud::Vision.new(
        project_id: "polynomial-net-212709",
        credentials: "/Users/ninomiyakouichirou/RubymineProjects/key/Project-9d62f14f14ed.json"
    )
    images = params[:images]
    count = images.length
    logger.debug "images123"
    logger.debug count
    i = 0
    j = 0

    # ファイルをダウンロードした状態じゃないとスコアは出せない？
    count.times do |i|
      file_name = images[i]["id"]
      # Performs label detection on the image file
      labels = vision.image(file_name).labels
      logger.debug "gazou"
      labels.each do |label|
        puts "Labels:"
        puts label.description
        puts label
        if label.score > 0.7 then
          p "ok"
        end
      end
     end
    storage = Google::Cloud::Storage.new(
        project_id: "polynomial-net-212709",
        credentials: "/Users/ninomiyakouichirou/RubymineProjects/key/My First Project-78cf42cd92b2.json"
    )

    # bucket名を入力
    bucket_name = "ninomiya_bucket"

    # bucketを指定
    bucket = storage.bucket bucket_name


    # logger.debug result[:count]

    count.times do |j|
      name = images[j]["id"]
      logger.debug "images456"
      logger.debug j
      open(images[j]["src"]) { |image|
      File.open(name+".jpg","wb") do |file|
        file.puts image.read
      end
      }

      #アップロード元、アップロード先ディレクトリ
      bucket.create_file "/Users/ninomiyakouichirou/RubymineProjects/rails-training-image-search/rails-training-image-search/"+name+".jpg",
                         "/screenshot/"+name+".jpg",
                         # content_type: cover_image.content_type,
                         acl: "public"

      image_path = "https://storage.googleapis.com/ninomiya_bucket//screenshot/"+name+".jpg"
      character = images[i]["title"]
      genre = 1

      # Resultsクラス(resultテーブル用のモデル)のcreateメソッドを実行・DB上のresultテーブルにレコードを新規登録
      question = Question.create({:image_path => image_path, :genre => genre, :character_string => character });
      end
        respond_to do |format|
          format.json {
            render :json => { status: "ok", question: question.attributes }
          }
    end
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