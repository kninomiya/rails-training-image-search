class QuestionsImageController < ApplicationController
  require "google/cloud/storage"

  storage = Google::Cloud::Storage.new(
      project_id: "polynomial-net-212709",
      credentials: "/Users/ninomiyakouichirou/RubymineProjects/key"
  )

  bucket = storage.bucket "task-attachments"

  file = bucket.file "path/to/my-file.ext"

# Download the file to the local file system
  file.download "/tasks/attachments/#{file.name}"

# Copy the file to a backup bucket
  backup = storage.bucket "task-attachment-backups"
  file.copy backup, file.name
  def create

  end

end
