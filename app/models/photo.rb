class Photo < ActiveRecord::Base

  belongs_to :space
  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 200 }

  mount_uploader :image, ImageUploader

end