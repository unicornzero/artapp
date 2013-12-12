require 'spec_helper'

describe NullTwitterHandle do

  let(:subject) { NullTwitterHandle.new }

  context '#to_s' do
    it 'returns "not added"' do
      result = subject.to_s

      expect(result).to eq "not yet added"
    end
  end

  context '#new' do
    it 'returns "not added"' do
      result = subject.new

      expect(result).to eq "not yet added"
    end
  end

  context '#format' do
    it 'returns "not added"' do
      result = subject.format

      expect(result).to eq "not yet added"
    end
  end

  context '#sanitize' do
    it 'returns "not added"' do
      result = subject.sanitize

      expect(result).to eq "not yet added"
    end
  end

end