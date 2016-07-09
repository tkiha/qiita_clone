class Tag < ActiveRecord::Base
  has_many :follow_tags
  has_many :users, through: :follow_tags
  has_many :tag_items
  has_many :items, through: :tag_items
end
