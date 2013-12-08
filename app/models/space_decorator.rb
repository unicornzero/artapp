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
    "@#{space.twitter}"
  end

  def twitter_link
    helper.link_to twitter_handle, twitter_url
  end

  private

  def helper
    ApplicationController.helpers
  end

  def twitter_url
    "http://www.twitter.com/#{space.twitter}"
  end
end