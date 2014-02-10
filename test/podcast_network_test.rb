require 'minitest/spec'
require 'minitest/autorun'
require 'feedzirra-podcast'

class PodcastNetworkTest < MiniTest::Unit::TestCase
  def setup
    text = File.open('etc/feeds/99percentinvisible.xml', 'r').read
    @feed = FeedzirraPodcast::Parser::Podcast.parse(text)
  end

  def test_network
    if @feed.network
      assert_equal true, @feed.networks?('http://feeds.99percentinvisible.org/99percentinvisible')
      assert_equal false, @feed.networks?('http://feeds.mypodcast.fm/mypodcast')
    end
  end
end
