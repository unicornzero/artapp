class Photo < ActiveRecord::Base

  belongs_to :album
  validates :album_id, presence: true
  validates :name, length: { maximum: 200 }

  mount_uploader :image, ImageUploader

end