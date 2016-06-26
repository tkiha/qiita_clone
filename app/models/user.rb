class User < ActiveRecord::Base
  has_secure_password

  has_many :items
  has_many :comments
  has_many :stocks
  has_many :items_stocked, through: :stocks, source: :item

  before_save { self.email = email.downcase }

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password_digest, presence: true

end

