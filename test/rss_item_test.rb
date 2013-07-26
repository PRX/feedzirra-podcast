require 'minitest/spec'
require 'minitest/autorun'
require 'feedzirra-podcast/parser'

class RSSItemTest < MiniTest::Unit::TestCase
  def setup
    text = File.open('etc/feeds/99percentinvisible.xml', 'r').read
    @feed = FeedzirraPodcast::Parser::Podcast.parse(text)
    @item = @feed.items.first
  end

  def test_title
    assert_equal '84- Ode to Ladislav Sutnar plus Trading Places with Planet Money', @item.title
  end
end
