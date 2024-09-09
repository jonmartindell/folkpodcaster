require_relative "wkar"
require_relative "gdrive"

class Recorder
  def record_folk_with_matt_watroba
    file = Wkar.record(180) # takes 180 minutes!
    gdrive = GDrive.new
    filename = "Folk with Matt Watroba #{file.mtime.strftime("%Y-%m-%d")}.aac"
    gdrive.upload_file(file, filename)
    File.delete(file)    # don't pay for volume space we don't need to
  end
end
