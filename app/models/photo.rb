class Photo < ActiveRecord::Base

  belongs_to :album
  validates :album_id, presence: true

end