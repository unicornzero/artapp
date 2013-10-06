Rails.configuration.stripe = {
  :publishable_key => CONFIG[:stripe_test_secret_key],
  :secret_key      => CONFIG[:stripe_test_public_key]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]