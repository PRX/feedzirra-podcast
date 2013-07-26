module FeedzirraPodcast
  module Parser
    class RSS2Item
      include SAXMachine
      include Feedzirra::FeedEntryUtilities

      # RSS 2.0 required

      element :title
      element :description

      # RSS 2.0 optional

      element :link
      element :author
      element :pubDate, as: :pubDateString
      element :source, as: :source_title
      element :source, as: :source_url, value: :url
      elements :category, as: :categories
      element :guid # isPermalink might be a thing
      element :enclosure, as: :enclosure_url, value: :url
      element :enclosure, as: :enclosure_length, value: :length
      element :enclosure, as: :enclosure_type, value: :type

      element :comments

      def pubDate
        Time.parse(pubDateString).utc if pubDateString.present?
      rescue ArgumentError
        nil
      end

      def source
        Struct.new(:title, :url).new(source_title, source_url)
      end

      def enclosure
        Struct.new(:url, :type, :length).new(enclosure_url, enclosure_length.try(:to_f), enclosure_type)
      end
    end
  end
end
