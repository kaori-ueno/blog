class Comment < ActiveRecord::Base
  validates :body, presence: true
  validates :user_id, presence: true
  validates :article_id, presence: true

  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  belongs_to :article

  def owner?(user)
    return false unless user
    user.id == owner.id
  end
end
