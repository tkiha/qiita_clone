class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :stocks, dependent: :destroy
  has_many :users_stocking, through: :stocks, source: :user
  has_many :tag_items, dependent: :destroy
  has_many :tags, through: :tag_items, source: :tag

  scope :recent, -> { order(created_at: :desc) }

  accepts_nested_attributes_for :tags

  def build_tags
    (5-tags.length).times do
      self.tags.build
    end
  end

  def tags_attributes=(tags)
    tags.each do |_, attr|
      if attr[:name].present?
        tag = Tag.find_or_create_by!(name: attr[:name])
        self.tag_items.find_or_initialize_by(tag: tag)
      end
    end
  end
end
