require "google_drive"

# Creates a session. This will prompt the credential via command line for the
# first time and save it to config.json file for later usages.
# See this document to learn how to create config.json:
# https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
session = GoogleDrive::Session.from_service_account_key("folkpodcast-a943fd7d30b7.json")

# Gets list of remote files.
session.files.each do |file|
  p file.title
end

# # Uploads a local file.
# session.upload_from_file("/path/to/hello.txt", "hello.txt", convert: false)

# # Downloads to a local file.
# file = session.file_by_title("hello.txt")
# file.download_to_file("/path/to/hello.txt")

# # Updates content of the remote file.
# file.update_from_file("/path/to/hello.txt")
