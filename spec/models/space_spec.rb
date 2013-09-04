require 'spec_helper'

describe Space do
  describe 'validations' do
    it 'should be valid with valid information' do
      space = build(:space)

      expect(space).to be_valid
    end
  end
end