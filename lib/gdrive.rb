require "google_drive"

# https://github.com/gimite/google-drive-ruby

class GDrive
  def initialize
    credentials = Google::Auth::UserRefreshCredentials.new(
      additional_parameters: {
        "access_type" => "offline",
        "include_granted_scopes" => "true"
      },
      client_id: ENV["CLIENT_ID"],
      client_secret: ENV["CLIENT_SECRET"],
      scope: [
        "https://www.googleapis.com/auth/drive",
        "https://spreadsheets.google.com/feeds/"
      ],
      redirect_uri: "http://localhost:3000/auth/google_drive/callback"
    )
    credentials.refresh_token = JSON.parse(File.read("google_config.json"))["refresh_token"]
    credentials.fetch_access_token!
    @session = GoogleDrive::Session.from_credentials(credentials)
  end

  def upload_file(file, filename)
    file = session.upload_from_file(file.path, filename, convert: false)
    file.acl.push(type: "anyone", role: "reader") # Make it be public via link
    file.reload_metadata
    file
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
