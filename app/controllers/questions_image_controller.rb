class QuestionsImageController < ApplicationController
  require "google/cloud/storage"

  def create
    storage = Google::Cloud::Storage.new(
        project_id: "polynomial-net-212709",
        credentials: "/Users/ninomiyakouichirou/RubymineProjects/key/My First Project-78cf42cd92b2.json"
    )

    # bucket名を入力
    bucket_name = "ninomiya_bucket"

    # bucketを指定
    bucket = storage.bucket bucket_name

    bucket.create_file StringIO.new("Hello world!"), "hello-world2.txt"
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


