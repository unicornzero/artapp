class Subscription < ActiveRecord::Base

  belongs_to :space
  belongs_to :user
  validates :space_id, presence: true

  def stripe_id
    stripe.stripe_id
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to find a stripe customer id: #{e.message}."
      false
  end

  def subscribe_and_get_id(stripetoken, current_user)
    self.stripe_cust_id = stripe.subscribe_pro_with_id(stripetoken, current_user)
    save
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to create your subscription: #{e.message}."
      false
  end

  def downgrade
    if self.plan == 'Pro'
      stripe.cancel_subscription
      self.plan = 'Downgrading to Basic'
      self.save
    end  
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to downgrade your subscription: #{e.message}."
      false
  end

  def stripe_last_charged
    charge = stripe.last_charged if self.stripe_cust_id
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to find last charged date: #{e.message}."
      false
  end

  def stripe
    @stripe ||= StripeService.new(self)
  end
end