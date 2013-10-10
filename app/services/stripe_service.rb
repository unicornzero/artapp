class StripeService

  def initialize(subscription)
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    @subscription = subscription
  end

  def get_stripe_customer
    @record = Stripe::Customer.retrieve(@subscription.stripe_cust_id).to_hash if @subscription.stripe_cust_id
  end

  def cancel_subscription
    Stripe::Customer.retrieve(@subscription.stripe_cust_id).cancel_subscription
  end

  def last_charged
    begin
      get_stripe_customer
      if @record["subscription"]
        Time.at(@record["subscription"]["current_period_start"]).strftime("%B %-d, %Y")
      else
        'No payment history available'
      end
    rescue Stripe::StripeError => e
      logger.error "StripeService Error: " + e.message
      errors.add :base, "StripeService cannot find last_charged: #{e.message}."
      false
    end
  end

  def subscribe_pro(current_user)
    @customer = Stripe::Customer.create(
      :card => @subscription.stripe_token,
      :plan => "01_basic",
      :email => current_user.email,
      :description => "Subscription ##{@subscription.id}"
    ).id
  end
end