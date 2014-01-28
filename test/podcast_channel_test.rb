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

  def test_excluded_tag
    assert_equal nil, @feed.itunes_new_feed_url
  end

  def test_sy_update_frequency
    assert_equal "1", @feed.sy_update_frequency_string
    assert_equal 1, @feed.sy_update_frequency
  end

  def test_sy_update_period
    assert_equal "hourly", @feed.sy_update_period_string
    assert_equal :hourly, @feed.sy_update_period
  end

  def test_sy_update_base
    assert_equal "2012-01-01T02:00:00+00:00", @feed.sy_update_base_string
    assert_equal Time.parse('2012-01-01T02:00:00+00:00'), @feed.sy_update_base
    assert_equal Time.parse('2012-01-01T02:00:00+00:00'), @feed.sy_updateBase
  end

  def test_itunes_categories
    assert_equal 1, @feed.itunes_categories
  end
end
