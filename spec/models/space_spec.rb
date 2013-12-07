require 'spec_helper'

describe Space do

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should_not allow_value("a" * 51).for(:name) }
  it { should have_many(:photos) }
  it { should belong_to(:user) }
  it { should have_one(:subscription) }
  it { should allow_value('venue').for(:plan) }
  it { should allow_value('artist').for(:plan) }
  it { should allow_value('www.myurl.com').for(:url) }
  it { should allow_value('description text').for(:description) }

  it 'should be valid with valid information' do
    space = build(:space)
    expect(space).to be_valid
  end

  describe 'setting a twitter handle' do
    xit 'saves the twitter handle'

    context 'when user has supplied their own "@" symbol' do
      it 'removes the "@" symbol before saving the record' do
        space = create(:space)
        space.twitter = '@ryleekeys'

        expect(space.twitter).to eq('ryleekeys')
      end
    end
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
