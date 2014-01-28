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
      element :"itunes:image", as: :itunes_image_href, value: :href

      element :"itunes:block", as: :itunes_block_string
      element :"itunes:isClosedCaptioned", as: :itunes_is_closed_captioned_string
      element :"itunes:order", as: :itunes_order_string

      # DC

      element :"dc:creator", as: :dc_creator
      element :"dc:created", as: :dc_created_string
      element :"dc:modified", as: :dc_modified_string
      element :"dc:replaces", as: :dc_replaces
      element :"dc:isReplacedBy", as: :dc_is_replaced_by

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

      def itunes_image
        Struct.new(:href).new(itunes_image_href)
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
      alias_method :itunes_isClosedCaptioned, :itunes_is_closed_captioned

      def itunes_order
        itunes_order_string.to_f if itunes_order_string.present?
      end

      def dc_created
        Time.parse(dc_created_string).utc if dc_created_string.present?
      rescue ArgumentError
        nil
      end

      def dc_modified
        Time.parse(dc_modified_string).utc if dc_modified_string.present?
      rescue ArgumentError
        nil
      end

      def dc_isReplacedBy
        dc_is_replaced_by
      end
    end
  end
end
