class Album < ActiveRecord::Base

  belongs_to :space
  validates :space_id, presence: true
  has_many :photos


end