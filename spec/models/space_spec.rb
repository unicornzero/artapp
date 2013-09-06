require 'spec_helper'

describe Space do
  describe 'validations' do

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should_not allow_value("a" * 51).for(:name) }

    it 'should be valid with valid information' do
      space = build(:space)

      expect(space).to be_valid
    end
  end
end