class FollowUser < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :user_cannot_follow_self

  def user_cannot_follow_self
    if follower_id == followed_id
      errors.add(:follower_id, ': 自分自身をフォローできません。')
    end
  end
end
