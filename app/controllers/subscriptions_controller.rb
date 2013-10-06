class SubscriptionsController < ApplicationController
  before_action :authorize

  def edit
    @subscription = current_resource
    @space = Space.find(params[:space_id])
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
    if params[:id]
      Subscription.find(params[:id])
    end
  end

end