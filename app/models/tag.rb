class Tag < ActiveRecord::Base
  has_many :follow_tags
  has_many :tag_items
end
