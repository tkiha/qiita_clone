class User < ActiveRecord::Base
  has_secure_password

  has_many :items
  has_many :comments
  has_many :stocks
  has_many :items_stocked, through: :stocks, source: :item
  has_many :active_follow_users, class_name: 'FollowUser', foreign_key: :follower_id
  has_many :passive_follow_users, class_name: 'FollowUser', foreign_key: :followed_id
  has_many :following, through: :active_follow_users, source: :followed
  has_many :followers, through: :passive_follow_users, source: :follower

  before_save { self.email = email.downcase }

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password_digest, presence: true

  def feed_items
    # TODO: 後ほどfollowしてるtagとuserのitemを取得する
    Item.all.recent
  end

  def follow(other_user)
    self.active_follow_users.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.active_follow_users.find_by!(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    self.following.include?(other_user)
  end

  def stock(item)
    self.stocks.find_or_create_by!(item: item)
  end

  def unstock(item)
    self.stocks.find_by!(item: item).destroy
  end

  def stocking?(item)
    self.items_stocked.include?(item)
  end
end
