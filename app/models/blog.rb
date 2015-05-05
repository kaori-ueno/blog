class Blog < ActiveRecord::Base
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :articles

  def is_owner?(user)
    return false unless user
    user_id === user.id
  end
end
