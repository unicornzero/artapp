class StripeWebhooksController < ApplicationController

require 'json'
skip_before_filter :verify_authenticity_token

  def endpoint
    respond_to do |format|
      format.json do
        request.body.rewind                   #https://github.com/rails/rails/pull/11353
        event = JSON.parse(request.body.read)
        process_event(event)
        render json: "blah blah blah", status: :ok 
      end
    end
  end

  def process_event(request)
    if request["type"] == 'charge.failed'
      if request["data"]
        customer = request["data"]["object"]["customer"]
        @sub = Subscription.find_by(stripe_cust_id: customer)
        if @sub
          @sub.payment_error
        else
        end
      end
    end
  end
end
