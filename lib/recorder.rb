require_relative "wkar"
require_relative "gdrive"

class Recorder
  def record_folk_with_matt_watroba
    starttime = Time.now
    file = Wkar.record(180) # takes 180 minutes!
    gdrive = GDrive.new
    filename = "Folk with Matt Watroba #{starttime.strftime("%Y-%m-%d")}.mp3"
    drive_file = gdrive.upload_file(file, filename)
    # When finished
    File.delete(file)    # don't pay for volume space we don't need to
  end
end
