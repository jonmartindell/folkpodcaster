require_relative "wkar"
require_relative "gdrive"

class Recorder
  def record_show!
    #    file = Wkar.record(180) # takes 180 minutes!
    file = Wkar.record # test with shorter default recording
    gdrive = GDrive.new
    filename = "Folk with Matt Watroba #{Time.now.strftime("%Y-%m-%d")}.aac"
    gdrive.upload_file(file, filename)
  end
end
