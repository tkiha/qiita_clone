class Item < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :users_stocking, through: :stocks, source: :user
  has_many :tag_items, dependent: :destroy
  has_many :tags, through: :tag_items, source: :tag

  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  validates :aasm_state, presence: true

  scope :recent, -> { order(published_at: :desc) }  # items.published が前につくはずなので、 recent_published とはしない
  scope :recent_created, -> { order(created_at: :desc) }

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

  # acts-as-taggable-onを使えば、このあたりすっきりしそうな気がします。
  # https://github.com/mbleigh/acts-as-taggable-on
  # http://ruby-rails.hatenadiary.com/entry/20150225/1424858414
  def tags=(tag_list)
    self.tag_items.destroy_all
    tag_array = tag_list.split.uniq
    tag_array.each do |tag_name|
      tag = Tag.find_or_create_by!(name: tag_name)
      self.tag_items.find_or_initialize_by(tag: tag)
    end
  end
end
