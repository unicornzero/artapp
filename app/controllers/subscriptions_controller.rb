class SubscriptionsController < ApplicationController
  before_action :authorize

  def edit
    @subscription = current_resource
    @space = Space.find(params[:space_id])
    @last_charged = @subscription.stripe_last_charged
  end

  def update
    flash[:deets] = params
    if params[:stripeToken]
      @subscription = Subscription.find(params[:id])
      @subscription.update_attributes(stripe_token: params[:stripeToken])
      @subscription.subscribe_and_get_id(current_user)
      if @subscription.stripe_cust_id
        @subscription.attributes = { space_id: params[:space_id], 
          user_id: current_user.id, plan: 'Pro' }
        if @subscription.save
          flash[:success] = 'Your account has been upgraded to Pro!'
          redirect_to '/account'
        else
          redirect_to root_path
        end
      else
        redirect_to root_path 
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @space = Space.find(@subscription.space_id)
    @subscription.downgrade
    flash[:message] = 'Your subscription has been cancelled.'
    redirect_to edit_space_subscription_path(@space, @subscription)
  end

private
  def current_resource
    if params[:id]
      Subscription.find(params[:id])
    end
  end

end