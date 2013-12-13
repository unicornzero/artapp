require 'spec_helper'

describe UrlLink do
  context '#build' do
    context 'when provided a url' do
      it 'returns an instance of UrlLink' do
        url = "http://www.mywebsite.com"
        result = UrlLink.build(url)

        expect(result).to be_an_instance_of(UrlLink)
      end
    end

    context 'when not provided a url' do
      it 'returns an instance of NullUrlLink' do
        result = UrlLink.build

        expect(result).to be_an_instance_of(NullUrlLink)
      end
    end
  end

  context '#pretty_url' do
    let(:pretty_www_url) { "www.mywebsite.com" }
    it 'returns "www.mywebsite.com" for "http://www.mywebsite.com/"' do
      url = "http://www.mywebsite.com/"
      result = UrlLink.build(url).pretty_url

      expect(result).to eq pretty_www_url
    end

    it 'returns "www.mywebsite.com" for "http://www.mywebsite.com"' do
      url = "http://www.mywebsite.com"
      result = UrlLink.build(url).pretty_url

      expect(result).to eq pretty_www_url
    end

    it 'returns "www.mywebsite.com" for "www.mywebsite.com"' do
      url = "www.mywebsite.com"
      result = UrlLink.build(url).pretty_url

      expect(result).to eq pretty_www_url
    end

    it 'returns "www.mywebsite.com" for "www.mywebsite.com/"' do
      url = "www.mywebsite.com/"
      result = UrlLink.build(url).pretty_url

      expect(result).to eq pretty_www_url
    end

    it 'returns "mywebsite.com" for "mywebsite.com"' do
      url = "mywebsite.com"
      result = UrlLink.build(url).pretty_url

      expect(result).to eq "mywebsite.com"
    end

    it 'returns "mywebsite.com" for "mywebsite.com/"' do
      url = "mywebsite.com/"
      result = UrlLink.build(url).pretty_url

      expect(result).to eq "mywebsite.com"
    end
  end

  context '#full_url' do
    it 'returns "http://www.mywebsite.com" for "http://www.mywebsite.com/"' do
      url = "http://www.mywebsite.com/"
      result = UrlLink.build(url).full_url

      expect(result).to eq "http://www.mywebsite.com"
    end
  end
end