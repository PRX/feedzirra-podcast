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
      elements :"itunes:category", as: :itunes_categories, value: :text
      element :"itunes:image", as: :itunes_image, value: :href
      element :"itunes:keywords", as: :itunes_keywords_string

      element :"itunes:block", as: :itunes_block_string
      element :"itunes:complete", as: :itunes_complete_string
      element :"itunes:new-feed-url", as: :itunes_new_feed_url

      # Syndication RSS

      # element :"sy:updatePeriod"
      # element :"sy:updateFrequency"
      # element :"sy:updateBase"

      # Misc

      element :issn

      def itunes_owner
        _email = itunes_owner_object ? itunes_owner_object.email : nil
        _name = itunes_owner_object ? itunes_owner_object.name : nil
        Struct.new(:email, :name).new(_email, _name)
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
    end
  end
end
