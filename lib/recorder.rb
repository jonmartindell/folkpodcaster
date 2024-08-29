require_relative "wkar"
require_relative "gdrive"

class Recorder
  def record_show!
    file = Wkar.record # takes 180 minutes!
    gdrive = GDrive.new
    filename = "Folk with Matt Watroba #{Time.now.strftime("%Y-%m-%d")}.aac"
    gdrive.upload_file(file, filename)
  end
end
