class Stock < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :user_id, uniqueness: { scope: :item_id }
  validate :user_cannot_stock_self_posted_item

  def user_cannot_stock_self_posted_item
    item = Item.find item_id
    if user_id == item.user.id
      errors.add(:follower_id, ': 自分の投稿はストックできません。')
    end
  end
end
