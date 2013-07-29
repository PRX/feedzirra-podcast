require 'feedzirra-podcast/parser/itunes_owner'

module FeedzirraPodcast
  module Parser
    class PodcastItem < FeedzirraPodcast::Parser::RSS2Item

      # iTunes

      element :"itunes:author", as: :itunes_author
      element :"itunes:subtitle", as: :itunes_subtitle
      element :"itunes:summary", as: :itunes_summary
      element :"itunes:explicit", as: :itunes_explicit_string
      element :"itunes:duration", as: :itunes_duration_string
      element :"itunes:keywords", as: :itunes_keywords_string
      element :"itunes:image", as: :itunes_image, value: :href

      element :"itunes:block", as: :itunes_block_string
      element :"itunes:isClosedCaptioned", as: :itunes_is_closed_captioned_string
      element :"itunes:order", as: :itunes_order_string

      # DC

      element :"dc:creator", as: :dc_creator
      element :"dc:created", as: :dc_created_string

      # Content

      element :"content:encoded", as: :content_encoded

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

      def itunes_duration
        Periodic.parse(itunes_duration_string) if itunes_duration_string.present?
      # rescue
      #   nil
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

      def itunes_is_closed_captioned
        case itunes_is_closed_captioned_string
        when "yes"
          true
        else
          false
        end
      end

      def itunes_order
        itunes_order_string.to_f if itunes_order_string.present?
      end

      def dc_created
        Time.parse(dc_created_string).utc if dc_created_string.present?
      rescue ArgumentError
        nil
      end
    end
  end
end
