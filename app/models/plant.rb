class Plant < ApplicationRecord
  has_many :plantings, dependent: :destroy
  belongs_to :user
end
