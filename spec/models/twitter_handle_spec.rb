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

    it 'returns "not yet added" for ""' do
      handle = ""
      result = TwitterHandle.build(handle).format

      expect(result).to eq "not yet added"
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