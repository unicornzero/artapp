require 'spec_helper'

describe Subscription do
  context 'validations' do
    it 'should pass with valid information' do
      user = create(:user)
      space = create(:space)
      subscription = Subscription.new(user_id: user.id, space_id: space.id)
      expect(subscription).to be_valid
    end

    it { should validate_presence_of(:user_id) }
    it { should belong_to(:user) }
    it { should belong_to(:space) }

  end
end
