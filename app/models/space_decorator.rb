class SpaceDecorator
  attr_accessor :space

  delegate :photos, :name, :description, to: :space

  def initialize(space)
    @space = space
  end

  def website
    helper.link_to space.url, space.url
  end

  def twitter_handle
    tweeter.format
  end

  def twitter_link
    helper.link_to twitter_handle, twitter_url
  end

  private

  def helper
    ApplicationController.helpers
  end

  def twitter_url
    "http://www.twitter.com/#{twitter_name}"
  end

  def tweeter
    TwitterHandle.build(space.twitter)
  end

  def twitter_name
    tweeter.sanitize
  end
end