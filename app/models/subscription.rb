class Subscription < ActiveRecord::Base

  belongs_to :space
  belongs_to :user
  validates :space_id, presence: true

  attr_accessor :stripe_token

  def subscribe_pro(stripetoken, current_user)
    stripe.subscribe_pro(stripetoken, current_user)
  end

  def stripe_id
    stripe.stripe_id
  end

  def downgrade
    if self.plan == 'Pro'
      stripe_cancel_pro
      self.plan = 'Downgrading to Basic'
      self.save
    end
  end

  def stripe_cancel_pro
    stripe.cancel_subscription
  end

  def stripe_last_charged
    begin 
      stripe.last_charged
    rescue
      'No record available'
    end
  end

  def stripe
    @stripe ||= StripeService.new(self)
  end
end