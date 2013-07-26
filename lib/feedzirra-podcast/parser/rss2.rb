require 'feedzirra-podcast/parser/rss2_channel_image'

module FeedzirraPodcast
  module Parser
    class RSS2
      include SAXMachine
      include Feedzirra::FeedUtilities

      # RSS 2.0 required

      element :link
      element :title
      element :description

      # RSS 2.0 optional

      element :language
      element :copyright
      element :managingEditor
      element :webMaster
      element :pubDate, as: :pub_date_string
      element :lastBuildDate, as: :last_build_date_string
      elements :category, as: :categories
      element :image, class: FeedzirraPodcast::Parser::RSS2ChannelImage
      element :docs

      element :generator
      element :rating
      element :ttl
      # skipDays
      # skipHours

      # cloud
      # textinput

      # elements :item, as: :items, class: RSS2Item

      attr_accessor :feed_url

      def self.able_to_parse?(xml) #:nodoc:
        (/\<rss|\<rdf/ =~ xml)
      end

      def pubDate
        Time.parse(pub_date_string).utc if pub_date_string.present?
      rescue ArgumentError
        nil
      end

      def lastBuildDate
        Time.parse(last_build_date_string).utc if last_build_date_string.present?
      rescue ArgumentError
        nil
      end
    end
  end
end
