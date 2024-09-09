require "dotenv/tasks"
require_relative "lib/recorder"

# Rakefile
task default: :dotenv do
  # puts "Recording folk show: #{Time.now}"
  # Recorder.new.record_folk_with_matt_watroba
  # puts "Done: #{Time.now}."
  puts "Uploading file..."
  file = File.new(Wkar::DEFAULT_FILENAME, "r")
  puts "File path: #{file.path}, file size: #{file.size}"
  gdrive = GDrive.new
  filename = "Folk with Matt Watroba #{file.mtime.strftime("%Y-%m-%d")}.aac"
  gdrive.upload_file(file, filename)
  puts "Uploaded file"
  puts "Files on drive: #{gdrive.list_files}"
  File.delete(file)    # don't pay for volume space we don't need to
end
