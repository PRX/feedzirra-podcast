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
	<itunes:keywords> 	feed.itunes_keywords (Array of Strings)
						feed.itunes_keywords_string

	<itunes:block>	 	feed.itunes_block (true, false)
						feed.itunes_block_string
	<itunes:complete> 	feed.itunes_complete (true, false)
						feed.itunes_complete_string
	<itunes:new-feed-url>	feed.itunes_new_feed_url

	<issn>				feed.issn

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

### Helpers

The `feedburner?` method on feed objects will try to tell you if the feed been proxied by Feedburner
