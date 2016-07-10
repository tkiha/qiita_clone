class FollowTag < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  validates :user_id, presence: true
  validates :tag_id, presence: true
  validates :user_id, uniqueness: { scope: :tag_id }
end

