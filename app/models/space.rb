class Space < ActiveRecord::Base
  has_many :albums
  has_many :photos, through: :albums
  
  validates :name, presence:   true,
                  length: { maximum: 50 }, 
                  uniqueness: true

  after_create :create_default_album

private
  def create_default_album
    self.albums.create(name: "default album")
  end

end
