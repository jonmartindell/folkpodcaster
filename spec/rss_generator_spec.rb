require "rss_generator"

describe RssGenerator do
  subject { RssGenerator.new(file: "spec/fixtures/rss.xml") }

  describe ".add_show" do
    it "adds a show to the list of items" do
      show_time = Time.now
      subject.add_show(url: "https://example.com/show.aac", title: "New Podcast Show", date: show_time, length_bytes: 1234)
      expect(subject.items.count).to eq 2
      last_item = subject.items.last
      expect(last_item.title).to eq "New Podcast Show"
      expect(last_item.enclosure.url).to eq "https://example.com/show.aac"
      expect(last_item.enclosure.length).to eq 1234
      expect(last_item.pubDate).to eq show_time.utc
    end
  end

  describe "initialize" do
    it "reads the existing rss file" do
      expect(subject.channel.title).to eq "Folk with Matt Watroba"
      expect(subject.channel.items.count).to eq 1
    end
  end

  describe "save!" do
    it "saves the changes to the default file" do
      filename = "spec/fixtures/newrss.xml"
      subject.add_show(url: "https://example.com/show.aac", title: "New Podcast Show", date: Time.now, length_bytes: 1234)
      subject.save!(out_file: filename)
      new_rss = RSS::Parser.parse(File.read(filename))
      expect(new_rss.items.last.title).to eq "New Podcast Show"
      File.delete(filename)
    end
  end
end
