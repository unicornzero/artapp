class SubscriptionsController < ApplicationController
  before_action :authorize

  def edit
    @space = current_resource
    @subscription = @space.subscription
  end

  def update
    flash[:deets] = params
    if params[:stripeToken]
      @subscription = Subscription.find(params[:id])
      @subscription.subscribe_pro(params[:stripeToken], current_user)
      if @subscription.stripe_id
        @subscription.space_id = params[:space_id]
        @subscription.user_id = current_user.id
        @subscription.stripe_customer_token = params[:stripeToken]
        @subscription.stripe_cust_id = @subscription.stripe_id
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

  def oldsubscribe_pro
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    @customer = Stripe::Customer.create(
      :card => params[:stripeToken],
      :plan => "01_basic",
      :email => current_user.email
    )
  end

  def oldstripe_customer_id
    @customer.id
  end

  def stripe_last_charged
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    charges = Stripe::Charge.all(:customer => @subscription.stripe_cust_id)
    c.delinquent
    c.subscription.current_period_start
  end

  def stripe_cancel_pro
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    account = Stripe::Customer.retrieve(@subscription.stripe_cust_id)
    account.cancel_subscription
  end

  def current_status
    Stripe.api_key = CONFIG[:stripe_test_secret_key]
    charges = Stripe::Charge.all(:customer => @subscription.stripe_cust_id)
    c.subscription.status
  end
end