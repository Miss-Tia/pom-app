class Category < ApplicationRecord
  has_many :journal_entries
end
