require 'minitest/spec'
require 'minitest/autorun'
require 'feedzirra-podcast'

class PodcastChannelTest < MiniTest::Unit::TestCase
  def setup
    text = File.open('etc/feeds/99percentinvisible.xml', 'r').read
    @feed = FeedzirraPodcast::Parser::Podcast.parse(text)
  end

  def test_itunes_author
    assert_equal 'Roman Mars', @feed.itunes_author
  end

  def test_itunes_owner
    assert_equal 'roman_mars@yahoo.com', @feed.itunes_owner.email
  end
end
