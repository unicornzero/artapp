class Subscription < ActiveRecord::Base

  belongs_to :space
  belongs_to :user
  validates :space_id, presence: true

  attr_accessor :stripe_token

  def subscribe_pro(stripetoken, current_user)
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    @customer = Stripe::Customer.create(
      :card => stripetoken,
      :plan => "01_basic",
      :email => current_user.email
      #add a description
    )
  end

  def stripe_id
  	@customer.id
  end

  def downgrade
    if self.plan == 'Pro'
      stripe_cancel_pro
      self.plan = 'Downgrading to Basic'
      self.save
    end
  end

  def stripe_cancel_pro
    begin 
      Stripe.api_key = CONFIG[:stripe_test_secret_key]
      #account = Stripe::Customer.retrieve(stripe_cust_id)
      #@last_charged = Time.at(account["subscription"]["current_period_start"])
      #account.cancel_subscription if account.subscription.status == 'active'
      Stripe::Customer.retrieve(stripe_cust_id).cancel_subscription
    rescue
      'Cancellation unsuccessful'
    end
  end

  def stripe_last_charged
    begin 
      Stripe.api_key = CONFIG[:stripe_test_secret_key]
      account = Stripe::Customer.retrieve(stripe_cust_id)["subscription"]["current_period_start"]
      Time.at(account)
    rescue
      'No record available'
    end
  end
end