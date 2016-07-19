class User < ActiveRecord::Base
  has_secure_password

  has_many :items
  has_many :comments
  has_many :stocks
  has_many :items_stocked, through: :stocks, source: :item
  # 細かいですが、class_nameもシンボルで統一したいです。
  has_many :active_follow_users, class_name: :FollowUser, foreign_key: :follower_id
  has_many :passive_follow_users, class_name: :FollowUser, foreign_key: :followed_id
  has_many :following, through: :active_follow_users, source: :followed
  has_many :followers, through: :passive_follow_users, source: :follower
  has_many :follow_tags
  has_many :tags_followed, through: :follow_tags, source: :tag

  before_save { self.email = email.downcase }

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password_digest, presence: true

  def feed_items
    Item.where(user: self.following).union(
      Item.joins(tags: :users).where(users: {id: self.id})
    ).uniq.recent.published
  end

  def follow(other_user)
    self.active_follow_users.find_or_create_by!(followed_id: other_user.id)
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

  def follow_tag(tag)
    self.follow_tags.find_or_create_by!(tag: tag)
  end

  def unfollow_tag(tag)
    self.follow_tags.find_by!(tag: tag).destroy
  end

  def following_tag?(tag)
    self.tags_followed.include?(tag)
  end
end
