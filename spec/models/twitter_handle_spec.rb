require 'spec_helper'

describe TwitterHandle do
  
  context '#build' do
    context 'when provided a handle' do
      it 'returns an instance of TwitterHandle' do
        handle = "handle"
        result = TwitterHandle.build(handle)

        expect(result).to be_an_instance_of(TwitterHandle)
      end
    end

    context 'when not provided a handle' do
      it 'returns an instance of NullTwitterHandle' do
        result = TwitterHandle.build

        expect(result).to be_an_instance_of(NullTwitterHandle)
      end
    end
  end

  context '#format' do
    it 'returns "@handle" for "handle"' do
      handle = "handle"
      result = TwitterHandle.build(handle).format

      expect(result).to eq "@handle"
    end

    it 'returns "@handle" for "@handle"' do
      handle = "@handle"
      result = TwitterHandle.build(handle).format

      expect(result).to eq "@handle"
    end

    it "returns 'I18n.t('twitter.handle_not_yet_set') for ''" do
      handle = ""
      result = TwitterHandle.build(handle).format
      null_twitter_string = I18n.t('twitter.handle_not_yet_set')

      expect(result).to eq null_twitter_string
    end
  end

  context '#sanitize' do
    it 'returns "handle" for "handle"' do
      handle = "handle"
      result = TwitterHandle.build(handle).sanitize

      expect(result).to eq "handle"
    end

    it 'returns "handle" for "@handle"' do
      handle = "@handle"
      result = TwitterHandle.build(handle).sanitize

      expect(result).to eq "handle"
    end
  end

end