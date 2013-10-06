class SubscriptionsController < ApplicationController
  before_action :authorize

  def new
    @space = current_resource
    @subscription = @space.build_subscription(user_id: current_user.id)
  end

  def index
    @space = current_resource
    if @space.subscription
      @subscription = @space.subscription
    else
      @subscription = @space.build_subscription
    end
  end

  def create
    if params[:stripeToken]
      subscribe_pro
      if stripe_customer_id
        @subscription = Subscription.new
        @subscription.space_id = params[:space_id]
        @subscription.user_id = current_user.id
        @subscription.stripe_customer_token = params[:stripeToken]
        @subscription.stripe_cust_id = stripe_customer_id
        @subscription.plan = 'Pro'
        if @subscription.save
          flash[:success] = 'Your account has been upgraded to Pro!'
          redirect_to '/account'
        else
          flash.now[:oops] = 'Upgrade nooooo successful'
          flash[:error] = 'Upgrade not successful'
          redirect_to root_path
        end
      else
        flash.now[:oops] = 'Upgrade nooooo successful'
        flash[:error] = 'Upgrade not successful'
        redirect_to root_path 
      end
    else
      flash.now[:oops] = 'Upgrade nooooo successful'
      flash[:error] = 'Upgrade not successful'
      redirect_to root_path
    end
  end

private
  def current_resource
    if params[:space_id]
      Space.find(params[:space_id])
    end
  end

private
  def subscribe_pro
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    @customer = Stripe::Customer.create(
      :card => params[:stripeToken],
      :plan => "01_basic",
      :email => current_user.email
    )
  end

  def stripe_customer_id
    @customer.id
  end
end