class JournalEntry < ApplicationRecord
  belongs_to :user
  belongs_to :category
<<<<<<< HEAD
  belongs_to :prompt, optional: true
=======
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880

  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates :title, :content, :category_id, presence: true
end
