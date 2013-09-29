class Subscription < ActiveRecord::Base

  belongs_to :user
  belongs_to :space
  validates :user_id, presence: true


end