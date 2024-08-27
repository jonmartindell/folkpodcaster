require "google_drive"

# https://github.com/gimite/google-drive-ruby

class GDrive
  def initialize
    @session = GoogleDrive::Session.from_service_account_key("folkpodcast-a943fd7d30b7.json")
  end

  def upload_file(file)
    session.upload_from_file(file.path, File.basename(file.path), convert: false)
  end

  def list_files
    session.files.map(&:title)
  end

  def read_file(filename)
    # # Downloads to a local file.
    # file = session.file_by_title("hello.txt")
    # file.download_to_file("/path/to/hello.txt")
    session.file_by_title(filename)
  end

  private

  attr_accessor :session
end
