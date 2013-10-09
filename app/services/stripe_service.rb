class StripeService

  def initialize(subscription)
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    @subscription = subscription
  end

  def cancel_subscription
    Stripe::Customer.retrieve(@subscription.stripe_cust_id).cancel_subscription
  end

  def last_charged
  begin
    account = Stripe::Customer.retrieve(@subscription.stripe_cust_id).to_hash
    if account["subscription"]
      Time.at(account["subscription"]["current_period_start"]).strftime("%B %-d, %Y")
    else
      'No payment history available'
    end
  rescue Stripe::StripeError => e
    logger.error "StripeService Error: " + e.message
    errors.add :base, "StripeService cannot find last_charged: #{e.message}."
    false
  end
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
    @customer.id || nil
  end
end