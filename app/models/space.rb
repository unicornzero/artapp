class Space < ActiveRecord::Base

  has_many :photos, dependent: :destroy
  validates :name, presence:   true,
                  length: { maximum: 50 }, 
                  uniqueness: true

end
