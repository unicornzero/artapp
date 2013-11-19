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

  def subscribe_and_get_id(current_user)
    self.update_attribute(:stripe_cust_id, stripe.subscribe_pro(current_user))
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to create your subscription: #{e.message}."
      false
  end

  def downgrade
    if self.plan == 'Pro'
      stripe.cancel_subscription
      self.update_attribute(:plan, 'Downgrading to Basic')
    end  
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to downgrade your subscription: #{e.message}."
      false
  end

  def payment_error
    self.update_attribute(:plan, 'Payment Error')
    save
    puts self.plan
    puts 'from model'
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