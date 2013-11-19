class StripeWebhooksController < ApplicationController

require 'json'
skip_before_filter :verify_authenticity_token

  def endpoint
    puts ' '
    respond_to do |format|
      format.json do
        puts 'got json'
        #puts params
        request.body.rewind                   #https://github.com/rails/rails/pull/11353
        event = JSON.parse(request.body.read)
        process_event(event)
        render json: "blah blah blah", status: :ok 
      end
      format.html { puts 'got html' ; puts params ; render text: "this is an endpoint" }
    end
  end

  def process_event(request)
    if request["type"] == 'charge.failed'
      puts "the type was a failed charge"
      if request["data"]
        customer = request["data"]["object"]["customer"]
        puts customer
        @sub = Subscription.find_by(stripe_cust_id: customer)
        @sub.payment_error
        if @sub
          @sub.payment_error
          puts "subscription is..."
          puts @sub
          puts @sub.plan
          puts "- meow -"
        else
          puts "subscription not found"
          puts "---"
        end
      end
    end
  end
end
