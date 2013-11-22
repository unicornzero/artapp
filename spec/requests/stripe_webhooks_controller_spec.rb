require 'spec_helper'
require 'json'
  
describe StripeWebhooksController do

  context '/stripe-endpoint' do
    it 'receives json' do
      test_request = {"created"=>1326853478, "livemode"=>false, "id"=>"evt_00000000000000", "type"=>"charge.failed", "object"=>"event", "data"=>{"object"=>{"id"=>"ch_00000000000000", "object"=>"charge", "created"=>1382547506, "livemode"=>false, "paid"=>false, "amount"=>1499, "currency"=>"usd", "refunded"=>false, "card"=>{"id"=>"card_00000000000000", "object"=>"card", "last4"=>"4242", "type"=>"Visa", "exp_month"=>4, "exp_year"=>2019, "fingerprint"=>"5oGDtLb5el8uqy1F", "customer"=>"cus_00000000000000", "country"=>"US", "name"=>"this", "address_line1"=>nil, "address_line2"=>nil, "address_city"=>nil, "address_state"=>nil, "address_zip"=>nil, "address_country"=>nil, "cvc_check"=>nil, "address_line1_check"=>nil, "address_zip_check"=>nil}, "captured"=>true, "refunds"=>nil, "balance_transaction"=>"txn_00000000000000", "failure_message"=>nil, "failure_code"=>nil, "amount_refunded"=>0, "customer"=>"cus_00000000000000", "invoice"=>"in_00000000000000", "description"=>nil, "dispute"=>nil, "metadata"=>{}}}, "stripe_webhook"=>{"created"=>1326853478, "livemode"=>false, "id"=>"evt_00000000000000", "type"=>"charge.failed", "object"=>"event", "data"=>{"object"=>{"id"=>"ch_00000000000000", "object"=>"charge", "created"=>1382547506, "livemode"=>false, "paid"=>false, "amount"=>1499, "currency"=>"usd", "refunded"=>false, "card"=>{"id"=>"card_00000000000000", "object"=>"card", "last4"=>"4242", "type"=>"Visa", "exp_month"=>4, "exp_year"=>2019, "fingerprint"=>"5oGDtLb5el8uqy1F", "customer"=>"cus_00000000000000", "country"=>"US", "name"=>"this", "address_line1"=>nil, "address_line2"=>nil, "address_city"=>nil, "address_state"=>nil, "address_zip"=>nil, "address_country"=>nil, "cvc_check"=>nil, "address_line1_check"=>nil, "address_zip_check"=>nil}, "captured"=>true, "refunds"=>nil, "balance_transaction"=>"txn_00000000000000", "failure_message"=>nil, "failure_code"=>nil, "amount_refunded"=>0, "customer"=>"cus_00000000000000", "invoice"=>"in_00000000000000", "description"=>nil, "dispute"=>nil, "metadata"=>{}}}}}
      post '/stripe-endpoint.json', test_request.to_json
      expect(response).to be_success
    end

    it 'saves a failed charge' do
      test_request = {"created"=>1326853478, "livemode"=>false, "id"=>"evt_00000000000000", "type"=>"charge.failed", "object"=>"event", "data"=>{"object"=>{"id"=>"ch_00000000000000", "object"=>"charge", "created"=>1382547506, "livemode"=>false, "paid"=>false, "amount"=>1499, "currency"=>"usd", "refunded"=>false, "card"=>{"id"=>"card_00000000000000", "object"=>"card", "last4"=>"4242", "type"=>"Visa", "exp_month"=>4, "exp_year"=>2019, "fingerprint"=>"5oGDtLb5el8uqy1F", "customer"=>"cus_00000000000111", "country"=>"US", "name"=>"this", "address_line1"=>nil, "address_line2"=>nil, "address_city"=>nil, "address_state"=>nil, "address_zip"=>nil, "address_country"=>nil, "cvc_check"=>nil, "address_line1_check"=>nil, "address_zip_check"=>nil}, "captured"=>true, "refunds"=>nil, "balance_transaction"=>"txn_00000000000000", "failure_message"=>nil, "failure_code"=>nil, "amount_refunded"=>0, "customer"=>"cus_00000000000111", "invoice"=>"in_00000000000000", "description"=>nil, "dispute"=>nil, "metadata"=>{}}}, "stripe_webhook"=>{"created"=>1326853478, "livemode"=>false, "id"=>"evt_00000000000000", "type"=>"charge.failed", "object"=>"event", "data"=>{"object"=>{"id"=>"ch_00000000000000", "object"=>"charge", "created"=>1382547506, "livemode"=>false, "paid"=>false, "amount"=>1499, "currency"=>"usd", "refunded"=>false, "card"=>{"id"=>"card_00000000000000", "object"=>"card", "last4"=>"4242", "type"=>"Visa", "exp_month"=>4, "exp_year"=>2019, "fingerprint"=>"5oGDtLb5el8uqy1F", "customer"=>"cus_00000000000111", "country"=>"US", "name"=>"this", "address_line1"=>nil, "address_line2"=>nil, "address_city"=>nil, "address_state"=>nil, "address_zip"=>nil, "address_country"=>nil, "cvc_check"=>nil, "address_line1_check"=>nil, "address_zip_check"=>nil}, "captured"=>true, "refunds"=>nil, "balance_transaction"=>"txn_00000000000000", "failure_message"=>nil, "failure_code"=>nil, "amount_refunded"=>0, "customer"=>"cus_00000000000111", "invoice"=>"in_00000000000000", "description"=>nil, "dispute"=>nil, "metadata"=>{}}}}}
      stripe_cust = test_request["data"]["object"]["customer"]
      subscription = create(:pro_subscription, stripe_cust_id: stripe_cust)

      post '/stripe-endpoint.json', test_request.to_json

      subscription.reload
      expect(subscription.plan).to eq('Payment Error')
    end

    it 'receives a constructed Stripe event' do
      h = {
        id: 'evt_1234567',
        type: 'charge.failed',
      }
      event = Stripe::Event.construct_from(h)
      subscription = create(:owned_subscription)

      post '/stripe-endpoint.json', event.to_json
      expect(subscription.plan).to eq('Basic')
    end
  end
end