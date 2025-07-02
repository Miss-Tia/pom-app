class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates :title, :content, :category_id, presence: true
end
