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
    )
  end

  def stripe_id
  	@customer.id
  end

  private
  def stripe_last_charged
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    charges = Stripe::Charge.all(:customer => stripe_cust_id)
    c.delinquent
    c.subscription.current_period_start
  end

  def stripe_cancel_pro
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    account = Stripe::Customer.retrieve(stripe_cust_id)
    account.cancel_subscription
  end

  def current_status
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    charges = Stripe::Charge.all(:customer => stripe_cust_id)
    c.subscription.status
  end
end