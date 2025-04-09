class User < ApplicationRecord
  has_many :gardens
  has_many :recipes
  has_many :journal_entries
end
