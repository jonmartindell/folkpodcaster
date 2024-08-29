require "dotenv/tasks"
require_relative "lib/recorder"

# Rakefile
task default: :dotenv do
  puts "Recording folk show: #{Time.now}"
  Recorder.new.record_folk_with_matt_watroba
  puts "Done: #{Time.now}."
end
