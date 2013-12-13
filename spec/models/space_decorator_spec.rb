require 'spec_helper'

describe SpaceDecorator do
  let(:space) { create(:space) }

  context '#twitter_handle' do
    it 'returns a twitter link' do
      space.twitter = 'mytweets'
      result = SpaceDecorator.new(space).twitter_handle

      expect(result).to eq "@mytweets"     
    end
  end

  context '#twitter_link' do
    it 'returns a twitter link for handle "mytweets"' do
      space.twitter = 'mytweets'
      result = SpaceDecorator.new(space).twitter_link

      expect(result).to eq "<a href=\"http://www.twitter.com/mytweets\">@mytweets</a>"     
    end

    it 'returns a twitter link for handle "mytweets"' do
      space.twitter = '@mytweets'
      result = SpaceDecorator.new(space).twitter_link

      expect(result).to eq "<a href=\"http://www.twitter.com/mytweets\">@mytweets</a>"     
    end
  end

  context '#website' do
    it 'returns a www website link for url "http://www.mywebsite.com"' do
      space.url = 'http://www.mywebsite.com'
      result = SpaceDecorator.new(space).website

      expect(result).to eq "<a href=\"http://www.mywebsite.com\">www.mywebsite.com</a>"
    end

    it 'returns a www website link for url "www.mywebsite.com"' do
      space.url = 'http://www.mywebsite.com'
      result = SpaceDecorator.new(space).website

      expect(result).to eq "<a href=\"http://www.mywebsite.com\">www.mywebsite.com</a>"
    end
  end

  pending 'handles presence and absence of http in url'
  pending 'handles absence of values'
end