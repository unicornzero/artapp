require 'spec_helper'

describe Subscription do
  context 'validations' do
    it 'should pass with valid information' do
      user = create(:user)
      space = create(:space)
      subscription = Subscription.new(user_id: user.id, space_id: space.id)
      expect(subscription).to be_valid
    end

    it 'should work with owned_subscription factory' do
      subscription = build(:owned_subscription)
      expect(subscription).to be_valid
    end

    it { should validate_presence_of(:space_id) }
    it { should belong_to(:user) }
    it { should belong_to(:space) }
    it { should allow_value(1).for(:user_id) }
    it { should allow_value(1).for(:space_id) }
    it { should allow_value('Pro').for(:plan) }
    it { should allow_value('Artist').for(:plan) }
    xit { should allow_value(Time.now).for(:last_paid) }
    it { should allow_value('something').for(:stripe_token) }
  end

  describe '#downgrade' do
    it 'stops pro subscription' do
      subscription = create(:pro_subscription)
      subscription.stub_chain(:stripe, :cancel_subscription)

      subscription.downgrade

      expect(subscription.plan).to eq('Downgrading to Basic')
    end
  end

  describe '#payment_error' do
    it 'sets active to "Payment Error"' do
      subscription = create(:pro_subscription)

      subscription.payment_error

      expect(subscription.plan).to eq('Payment Error')
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
