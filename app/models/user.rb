class User < ApplicationRecord
  has_secure_password

  has_many :gardens
  has_many :recipes
  has_many :plants
  has_many :plantings, through: :gardens
  has_many :journal_entries

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true
end
