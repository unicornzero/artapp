require 'spec_helper'

describe NullTwitterHandle do

  let(:subject) { NullTwitterHandle.new }
  let(:null_twitter_string) { I18n.t('twitter.handle_not_yet_set') }

  context '#to_s' do
    it "returns 'I18n.t('twitter.handle_not_yet_set')" do
      result = subject.to_s

      expect(result).to eq null_twitter_string
    end
  end

  context '#new' do
    it "returns 'I18n.t('twitter.handle_not_yet_set')" do
      result = subject.new

      expect(result).to eq null_twitter_string
    end
  end

  context '#format' do
    it "returns 'I18n.t('twitter.handle_not_yet_set')" do
      result = subject.format

      expect(result).to eq null_twitter_string
    end
  end

  context '#sanitize' do
    it "returns 'I18n.t('twitter.handle_not_yet_set')" do
      result = subject.sanitize

      expect(result).to eq null_twitter_string
    end
  end

end