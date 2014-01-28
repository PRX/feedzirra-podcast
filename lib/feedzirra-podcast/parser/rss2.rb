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

      element :"feedburner:info", as: :feedburner_info_uri, value: :uri
      element :"feedburner:info", as: :feedburner_info_xmlns, value: :"xmlns:feedburner"

      attr_accessor :feed_url

      def self.able_to_parse?(xml) #:nodoc:
        (/\<rss|\<rdf/ =~ xml)
      end

      def pubDate
        Time.parse(pub_date_string).utc if pub_date_string.present?
      rescue ArgumentError
        nil
      end
      alias_method :pub_date, :pubDate
      alias_method :pubdate, :pubDate

      def lastBuildDate
        Time.parse(last_build_date_string).utc if last_build_date_string.present?
      rescue ArgumentError
        nil
      end
      alias_method :last_build_date, :lastBuildDate

      def feedburner?
        !!feedburner_info_xmlns || !!feedburner_info_uri
      end

      def managing_editor
        managingEditor
      end
      alias_method :managingeditor, :managing_editor

      def web_master
        webMaster
      end
      alias_method :webmaster, :web_master
    end
  end
end
