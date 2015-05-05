class Blog < ActiveRecord::Base
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  def is_owner?(user)
    return false unless user
    user_id === user.id
  end
end
