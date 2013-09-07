class Album < ActiveRecord::Base

  belongs_to :space
  validates :space_id, presence: true
  has_many :photos
  validates :name, length: { maximum: 200 }


end