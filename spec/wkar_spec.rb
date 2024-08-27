require "wkar"

describe Wkar do
  describe ".record" do
    subject { described_class.record }

    let!(:expected_request) do
      stub_request(:get, /wkar.streamguys1.com\/wkarfm-web.aac\?uuid/)
        .with(
          headers: {
            "Accept" => "*/*",
            "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Accept-Language" => "en-US,en;q=0.6",
            "Range" => "bytes=0-",
            "Referer" => "https://www.wkar.org/",
            "Referrer-Policy" => "strict-origin-when-cross-origin",
            "Sec-Ch-Ua" => '"Chromium";v="128", "Not;A=Brand";v="24", "Brave";v="128"',
            "Sec-Ch-Ua-Mobile" => "?0",
            "Sec-Ch-Ua-Platform" => '"Linux"',
            "Sec-Fetch-Dest" => "audio",
            "Sec-Fetch-Mode" => "no-cors",
            "Sec-Fetch-Site" => "cross-site",
            "Sec-Gpc" => "1",
            "User-Agent" => "Ruby"
          }
        )
        .to_return(status: 200, body: "abcdefg", headers: {})
    end

    it "returns a file with the content received" do
      subject
      expect(expected_request).to have_been_made
      expect(subject).to be_a File
      expect(subject.read).to eq("abcdefg")
    end
  end
end
