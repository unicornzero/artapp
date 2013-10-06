require 'spec_helper'

describe Space do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should_not allow_value("a" * 51).for(:name) }
  it { should have_many(:photos) }
  it { should belong_to(:user) }
  it { should have_one(:subscription) }
  xit { should allow_value('active').for(:status) }
  xit { should allow_value('inactive').for(:status) }
  xit { should allow_value('basic').for(:version) }
  xit { should allow_value('pro').for(:version) }
  xit { should allow_value('artist').for(:version) }
  xit { should allow_value(true).for(:published_upgrade) }
  xit { should allow_value(false).for(:published_upgrade) }

  it 'should be valid with valid information' do
    space = build(:space)
    expect(space).to be_valid
  end

  context '#set_owner' do
    it 'associates to a user' do
      user = create(:user)
      space = create(:space)

      space.set_owner(user)

      expect(space.user_id).to eq(user.id)
    end
  end
end
