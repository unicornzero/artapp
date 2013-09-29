class Space < ActiveRecord::Base

  has_many :photos, dependent: :destroy
  belongs_to :user
  validates :name, presence:   true,
                  length: { maximum: 50 }, 
                  uniqueness: true

  def set_owner(person)
    update_column(:user_id, person.id)
  end
end
