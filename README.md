# Feedzirra-Podcast

A set of Feedzirra parsers intended to parse common RSS feeds used for podcasting.

At present, there is no specific attribute (DTD, namespace, etc) that indicates an RSS feed is a podcsat. In general, a feed that uses only standard RSS 2.0 elements is acceptable for representing a podcast. Because of this, `feedzirra-podcast` parsers will

Even though there is an RSS 2.0 parser included in this library, it is not explicitly intended to be used to parse any RSS feed. This library is only intended to handle feeds you expect to be podcasts.

### Compatibility

Unlike the parsers that are included with Feedzirra by default, these parsers do not try to normalize the names of similar elements from different types of feeds (RSS, Atom, etc).

If you add feedzirra-podcast parsers to the set of global Feedzirra parsers, it will likely match many feeds that would otherwise be handled by the native parsers. Your code would likely stop working if you had previously been using the normalized accessors.

If you want to avoid potential conflicts, you can directly pass feeds to the podcast parser, without registering it to Feedzirra.

	FeedzirraPodcast::Parser::Podcast.parse(feed_xml_string)

## Usage

The parser attempts to match the structure and naming conventions of the actual feed XML elements as closely as possible. `<link>` tags are accessed through `item.link`, etc. Some elements, such as `pubDate`, can be accessed with methods that match the element, or aliases that better adhere to ruby naming conventions (e.g. `pub_date`).

The goal is to support all elements common to podcast feeds. Currently not all elements are supported; as they are added, they will be listed below.

When it makes sense for an element's value to be parsed or tranformed into a non-string object, that will be done. The string value is always preserved, though.

When an element has children, such as `itunes:owner`, you can safely call the children directly (`feed.itunes_owner.email`) even when the feed doesn't include the parent element. You will get `nil` back for both calls to the parent or child

### Channel

	<link>				feed.link
	<title>				feed.title
	<description>		feed.description

	<language>			feed.language
	<copyright>			feed.copyright
	<managingEditor>	feed.managingEditor
	<webMaster>			feed.webMaster
	<pubDate>			feed.pubDate (Time)
						feed.pub_date_string (String)
	<lastBuildDate>		feed.lastBuildDate (Time)
						feed.last_build_date_string (String)
	<category>			feed.categories (Array of Strings)
	<image>				feed.image (RSS2ChannelImage)
						feed.image.url
						feed.image.title
						feed.image.link
						feed.image.width
						feed.image.height
						feed.image.description
	<docs>				feed.docs

	<generator>			feed.generator
	<rating>			feed.rating
	<ttl>				feed.ttl

	<item>				feed.items (Array)

	<itunes:author>		feed.itunes_author
	<itunes:owner>		feed.itunes_owner
						feed.itunes_owner.email
						feed.itunes_owner.name
	<itunes:explicit> 	feed.itunes_explicit (true, false, :clean)
						feed.itunes_explicit_string
	<itunes:subtitle> 	feed.itunes_subtitle
	<itunes:summary> 	feed.itunes_summary
	<itunes:image href>	feed.itunes_image.href
	<itunes:keywords> 	feed.itunes_keywords (Array of Strings)
						feed.itunes_keywords_string

	<itunes:block>	 	feed.itunes_block (true, false)
						feed.itunes_block_string
	<itunes:complete> 	feed.itunes_complete (true, false)
						feed.itunes_complete_string
	<itunes:new-feed-url>	feed.itunes_new_feed_url
	
	<sy:updatePeriod>	 feed.sy_updatePeriod (:hourly, :daily, etc)
	<sy:updateFrequency>	feed.sy_updateFrequency (Integer)
	<sy:updateBase>		feed.sy_updateBase (Time)

	<issn>				feed.issn
	<network>			feed.network

### Items

	<title>				item.title
	<description>		item.description

	<link>				item.link
	<author>			item.author
	<pubDate>			item.pubDate (Time)
	<source>			item.source
						item.source.title
						item.source.url
	<category>			item.categories (Array of Strings)
	<guid>				item.guid
	<enclosure>			item.enclosure
						item.enclosure.url
						item.enclosure.type
						item.enclosure.length

	<comments>			item.comments
	
	<dc:creator>		item.dc_creator
	<dc:created>		item.dc_created (Time)
	<dc:modified>		item.dc_modified (Time)
	<dc:replaces>		item.dc_replaces
	<dc:isReplacedBy>	item.dc_isReplacedBy
	
	<itunes:author>		feed.itunes_author
	<itunes:subtitle> 	feed.itunes_subtitle
	<itunes:summary> 	feed.itunes_summary
	<itunes:explicit> 	feed.itunes_explicit (true, false, :clean)
						feed.itunes_explicit_string
	<itunes:duration>	feed.itunes_duration (Number)
						feed.itunes_duration_string (String)
	<itunes:keywords> 	feed.itunes_keywords (Array of Strings)
						feed.itunes_keywords_string
	<itunes:image href>	feed.itunes_image.href
	<itunes:block>	 	feed.itunes_block (true, false)
						feed.itunes_block_string
	<itunes:isClosedCaptioned>	feed.itunes_is_closed_captioned (Boolean)
						feed.itunes_is_closed_captioned_string
	<itunes:order>		feed.itunes_order (Float)
						feed.itunes_order_string (String)
	
	<content:encoded>	item.content_encoded	

### Helpers

The `feedburner?` method on feed objects will try to tell you if the feed been proxied by Feedburner
