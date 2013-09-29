class SubscriptionsController < ApplicationController
  before_action :authorize

  def new
    @subscription = Subscription.new
    @subscription.user_id = current_user.id
  end

  def create
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    token = params[:stripeToken]
    if ( customer = Stripe::Customer.create(
      :card => token,
      :plan => "01_basic",
      :email => current_user.email
    ) )
      @subscription = Subscription.new
      @subscription.update_attributes(params.require(:subscription).permit(:user_id))
      @subscription.update_attribute(:stripe_customer_token, token)
      @subscription.update_attribute(:stripe_cust_id, customer.id)
      if @subscription.save
        redirect_to root_url, notice: 'You have Subscribed'
      else
        @subscription.user_id = current_user.id
        render :new, error: 'There was an error. Please retry.'
      end 
    else
      @subscription.user_id = current_user.id
      render :new, error: 'There was an error. Please retry.'
    end
  end

end