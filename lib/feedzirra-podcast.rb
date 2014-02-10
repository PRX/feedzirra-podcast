require 'periodic'
require 'feedzirra'

require 'feedzirra-podcast/parser/rss2'
require 'feedzirra-podcast/parser/rss2_channel_image'
require 'feedzirra-podcast/parser/rss2_item'

require 'feedzirra-podcast/parser/podcast'
require 'feedzirra-podcast/parser/podcast_item'

require 'feedzirra-podcast/parser/itunes_owner'

class Object
  def present?
    !blank?
  end

  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end
