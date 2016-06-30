class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :stocks, dependent: :destroy
  has_many :users_stocking, through: :stocks, source: :user

  scope :recent, -> { order(updated_at: :desc) }
end
