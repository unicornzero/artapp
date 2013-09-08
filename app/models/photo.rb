class Photo < ActiveRecord::Base

  belongs_to :album
  validates :album_id, presence: true
  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 200 }

  mount_uploader :image, ImageUploader

end