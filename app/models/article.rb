class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :blog_id, presence: true

  belongs_to :blog
  has_many :comments

  def is_owner?(user)
    return false unless user && blog
    blog.is_owner? user
  end
end
