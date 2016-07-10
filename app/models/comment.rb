class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :content, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
end
