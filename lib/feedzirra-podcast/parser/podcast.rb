require 'feedzirra-podcast/parser/podcast_item'

module FeedzirraPodcast
  module Parser
    class Podcast < FeedzirraPodcast::Parser::RSS2

      elements :item, as: :items, class: PodcastItem

      # iTunes

      element :"itunes:author", as: :itunes_author
      element :"itunes:owner", as: :itunes_owner_object, class: ItunesOwner
      element :"itunes:explicit", as: :itunes_explicit_string
      element :"itunes:subtitle", as: :itunes_subtitle
      element :"itunes:summary", as: :itunes_summary
      # elements :"itunes:category", as: :itunes_categories, value: :text
      element :"itunes:image", as: :itunes_image_href, value: :href
      element :"itunes:keywords", as: :itunes_keywords_string

      element :"itunes:block", as: :itunes_block_string
      element :"itunes:complete", as: :itunes_complete_string
      element :"itunes:new-feed-url", as: :itunes_new_feed_url

      # Syndication RSS

      element :"sy:updatePeriod", as: :sy_update_period_string
      element :"sy:updateFrequency", as: :sy_update_frequency_string
      element :"sy:updateBase", as: :sy_update_base_string

      # Misc

      element :issn
      element :network

      def itunes_owner
        _email = itunes_owner_object ? itunes_owner_object.email : nil
        _name = itunes_owner_object ? itunes_owner_object.name : nil
        Struct.new(:email, :name).new(_email, _name)
      end

      def itunes_image
        Struct.new(:href).new(itunes_image_href)
      end

      def itunes_explicit
        case itunes_explicit_string
        when "yes"
          true
        when "clean"
          :clean
        else
          false
        end
      end

      def itunes_keywords
        itunes_keywords_string.split(',').map(&:strip) if itunes_keywords_string.present?
      end

      def itunes_block
        case itunes_block_string
        when "yes"
          true
        else
          false
        end
      end

      def itunes_complete
        case itunes_complete_string
        when "yes"
          true
        else
          false
        end
      end

      def sy_update_period
        case sy_update_period_string
          when "hourly" then :hourly
          when "daily" then :daily
          when "weekly" then :weekly
          when "monthly" then :monthly
          when "yearly" then :yearly
          else nil
        end
      end
      alias_method :sy_updatePeriod, :sy_update_period

      def sy_update_frequency
        sy_update_frequency_string.to_i if sy_update_frequency_string
      end
      alias_method :sy_updateFrequency, :sy_update_frequency

      def sy_update_base
        Time.parse(sy_update_base_string) if sy_update_base_string.present?
      end
      alias_method :sy_updateBase, :sy_update_base
    end
  end
end
