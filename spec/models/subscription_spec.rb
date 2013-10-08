require 'spec_helper'

describe Subscription do
  context 'validations' do
    it 'should pass with valid information' do
      user = create(:user)
      space = create(:space)
      subscription = Subscription.new(user_id: user.id, space_id: space.id)
      expect(subscription).to be_valid
    end

    it { should validate_presence_of(:space_id) }
    it { should belong_to(:user) }
    it { should belong_to(:space) }
    it { should allow_value(1).for(:user_id) }
    it { should allow_value(1).for(:space_id) }
    it { should allow_value('Pro').for(:plan) }
    it { should allow_value('Artist').for(:plan) }
    xit { should allow_value(10).for(:rate) }
    xit { should allow_value(Time.now).for(:last_paid) }
    xit { should allow_value('active').for(:status) }
    xit { should allow_value('inactive').for(:status) }
    it { should allow_value('something').for(:stripe_customer_token) }

    xit 'should have fields for subscription status' do
      user = create(:user)
      space = create(:space, user_id: user.id)
      subscription = Subscription.new(user_id: user.id, space_id: space.id)
      subscription.last_paid = Time.now
      subscription.plan = 'Pro'
      subscription.rate = 10
      subscription.status = 'Active'

      expect(subscription).to be_valid
    end
  end

  describe '#downgrade' do
    it 'stops pro subscription' do
      user = create(:user)
      space = create(:space, user_id: user.id)
      subscription = Subscription.create(user_id: user.id, space_id: space.id,
        plan: 'Pro')
      subscription.stub(:stripe_cancel_pro) { true }

      subscription.downgrade

      expect(subscription.plan).to eq('Downgrading to Basic')
    end
  end

  describe '#since_last_paid' do
    xit 'should calculate days since last payment' do
      user = create(:user)
      space = create(:space)
      thirty_five_days = 60 * 60 * 24 * 35
      subscription = Subscription.new(
        user_id: user.id, 
        space_id: space.id,
        last_paid: Time.now - thirty_five_days
        ).save

      expect(subscription.since_last_paid).to be_within(1).of(35)
    end
  end
end
