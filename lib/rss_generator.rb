require "rss"
require "forwardable"

class RssGenerator
  extend Forwardable
  DEFAULT_FILENAME = "recordings/rss.xml"
  def_delegators :@rss, :channel, :items

  def initialize(file: DEFAULT_FILENAME)
    @rss = RSS::Parser.parse(File.read(file))
  end

  def add_show(title:, url:, date:, length_bytes:)
    new_item = items.first.dup
    new_item.title = title
    new_item.description = title
    new_item.pubDate = date.utc
    new_item.guid.content = SecureRandom.uuid
    new_item.enclosure.url = url
    new_item.enclosure.length = length_bytes
    items << new_item
  end

  def save!(out_file: DEFAULT_FILENAME)
    File.write(out_file, @rss)
  end
end
