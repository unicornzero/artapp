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
end