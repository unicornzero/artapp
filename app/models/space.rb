class Space < ActiveRecord::Base

  has_many :photos, dependent: :destroy
  has_one :subscription
  belongs_to :user
  validates :name, presence:   true,
                  length: { maximum: 50 }, 
                  uniqueness: true
  after_create :setup_subscription

  def set_owner(person)
    update_column(:user_id, person.id)
  end

  def setup_subscription
    create_subscription(user_id: user_id, plan: 'Basic').save
  end
end
