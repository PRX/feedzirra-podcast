require 'minitest/spec'
require 'minitest/autorun'
require 'feedzirra-podcast/parser'

class PodcastItemTest < MiniTest::Unit::TestCase
  def setup
    text = File.open('etc/feeds/99percentinvisible.xml', 'r').read
    @feed = FeedzirraPodcast::Parser::Podcast.parse(text)
    @item = @feed.items.first
  end

  def test_itunes_author
    assert_equal 'Roman Mars', @item.itunes_author
  end

  def test_duration
    assert_equal '31:04', @item.itunes_duration_string
    assert_equal 1864, @item.itunes_duration
  end

  def test_explicit
    assert_equal 'no', @item.itunes_explicit_string
    assert_equal false, @item.itunes_explicit
  end
end
