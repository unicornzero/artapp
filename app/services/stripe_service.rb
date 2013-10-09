class StripeService

  def initialize(subscription)
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    @subscription = subscription
  end

  def cancel_subscription
    Stripe::Customer.retrieve(@subscription.stripe_cust_id).cancel_subscription
  end

  def last_charged
    account = Stripe::Customer.retrieve(@subscription.stripe_cust_id)["subscription"]["current_period_start"]
    Time.at(account).strftime("%B %-d, %Y")
  end

  def subscribe_pro(stripetoken, current_user)
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
end