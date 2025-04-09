class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :journal_entry, optional: true
end
