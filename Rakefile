require "dotenv/tasks"
require_relative "lib/recorder"

# Rakefile
task default: :dotenv do
  puts "This is the default task at time: #{Time.now}"
  puts "Recording show!"
  Recorder.new.record_show!

  # if Time.now.strftime("%A") == "Sunday"
  #   puts "Recording show!"
  #   Recorder.new.record_show!
  # else
  #   puts "Skipping recording because it isn't Sunday"
  # end
end
