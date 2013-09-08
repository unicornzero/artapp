class Space < ActiveRecord::Base

  has_many :photos, dependent: :destroy
 # accepts_nested_attributes_for :photos
  validates :name, presence:   true,
                  length: { maximum: 50 }, 
                  uniqueness: true

end
