class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :recipes
end
