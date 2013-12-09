require 'spec_helper'

describe TwitterHandle do
  
  context '#format' do
    it 'returns "@handle" for "handle"' do
      handle = "handle"
      result = TwitterHandle.new(handle).format

      expect(result).to eq "@handle"
    end

    it 'returns "@handle" for "@handle"' do
      handle = "@handle"
      result = TwitterHandle.new(handle).format

      expect(result).to eq "@handle"
    end

    it 'returns "not yet added" for ""' do
      handle = ""
      result = TwitterHandle.build(handle).format

      expect(result).to eq "not yet added"
    end
  end

  context '#sanitize' do
    it 'returns "handle" for "handle"' do
      handle = "handle"
      result = TwitterHandle.new(handle).sanitize

      expect(result).to eq "handle"
    end

    it 'returns "handle" for "@handle"' do
      handle = "@handle"
      result = TwitterHandle.new(handle).sanitize

      expect(result).to eq "handle"
    end
  end

end