class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :stocks, dependent: :destroy
  has_many :users_stocking, through: :stocks, source: :user
  has_many :tag_items, dependent: :destroy
  has_many :tags, through: :tag_items, source: :tag

  scope :recent, -> { order(created_at: :desc) }

  include AASM

  aasm do
    state :draft, initial: true
    state :published

    event :publish do
      after do
        self.published_at = Time.now
      end
      transitions from: :draft, to: :published
    end

    event :return_to_draft do
      transitions from: :published, to: :draft
    end
  end

  def tags=(tag_list)
    self.tag_items.destroy_all
    tag_array = tag_list.split
    tag_array.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      self.tag_items.find_or_initialize_by(tag: tag)
    end
  end
end
