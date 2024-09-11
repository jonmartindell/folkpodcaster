require "net/http"
require "uri"

class Wkar
  DEFAULT_RECORDING_MINUTES = 0.20 # 12 seconds
  DEFAULT_UUID = SecureRandom.uuid[-9..]
  DEFAULT_FILENAME = "recordings/output.mp3" # I want it to overwrite because I use googledrive for long term persistence

  def self.record(minutes = DEFAULT_RECORDING_MINUTES)
    # Define the URL and create HTTP connection
    url = URI.parse("https://wkar.streamguys1.com/wkarfm-web.aac?uuid=#{DEFAULT_UUID}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    # Create a GET request with headers
    request = Net::HTTP::Get.new(url.request_uri)
    request["Accept"] = "*/*"
    request["Accept-Language"] = "en-US,en;q=0.6"
    request["Range"] = "bytes=0-"
    request["Sec-CH-UA"] = '"Chromium";v="128", "Not;A=Brand";v="24", "Brave";v="128"'
    request["Sec-CH-UA-Mobile"] = "?0"
    request["Sec-CH-UA-Platform"] = '"Linux"'
    request["Sec-Fetch-Dest"] = "audio"
    request["Sec-Fetch-Mode"] = "no-cors"
    request["Sec-Fetch-Site"] = "cross-site"
    request["Sec-GPC"] = "1"
    request["Referer"] = "https://www.wkar.org/"
    request["Referrer-Policy"] = "strict-origin-when-cross-origin"

    # Open the file to save the response
    File.open(DEFAULT_FILENAME, "wb") do |file|
      # Start the timer
      start_time = Time.now

      # Make the request and stream the response
      http.request(request) do |response|
        response.read_body do |chunk|
          # Calculate elapsed time
          elapsed_time = Time.now - start_time
          if elapsed_time % 600 == 0
            puts "Elapsed minutes: #{elapsed_time / 60}"
          end

          # Break the loop if x minutes have passed
          break if elapsed_time > minutes * 60

          # Write the chunk to the file
          file.write(chunk)
        end
        break
      end
    end
    File.new(DEFAULT_FILENAME, "r")
  end
end
