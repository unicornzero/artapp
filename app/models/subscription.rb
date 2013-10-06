class Subscription < ActiveRecord::Base

  belongs_to :user
  belongs_to :space
  validates :user_id, presence: true

  attr_accessor :stripe_token

  def current_plan
    plan || 'Basic'
  end
end