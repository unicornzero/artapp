require 'spec_helper'

describe SpaceDecorator do
  
  context '#website' do
    it 'returns a linked url' do
      space = create(:space)
      space.url = 'http://www.myweburl.com'
      result = SpaceDecorator.new(space).website

      expect(result).to eq "<a href=\"http://www.myweburl.com\">http://www.myweburl.com</a>"
    end
  end

  context '#twitter_handle' do
    it 'returns a twitter link' do
      space = create(:space)
      space.twitter = 'mytweets'
      result = SpaceDecorator.new(space).twitter_handle

      expect(result).to eq "@mytweets"     
    end
  end

  context '#twitter_link' do
    it 'returns a twitter link' do
      space = create(:space)
      space.twitter = 'mytweets'
      result = SpaceDecorator.new(space).twitter_link

      expect(result).to eq "<a href=\"http://www.twitter.com/mytweets\">@mytweets</a>"     
    end
  end

  pending 'handles both @ and no @ twitter handles'
  pending 'handles presence and absence of http in url'
  pending 'handle absence of values'
end