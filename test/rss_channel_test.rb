require 'minitest/spec'
require 'minitest/autorun'
require 'feedzirra-podcast'

class RSSChannelTest < MiniTest::Unit::TestCase
  def setup
    text = File.open('etc/feeds/99percentinvisible.xml', 'r').read
    @feed = FeedzirraPodcast::Parser::Podcast.parse(text)
  end

  def test_title
    assert_equal '99% Invisible', @feed.title
  end

  def test_feedburner
    assert_equal true, @feed.feedburner?
  end
end
