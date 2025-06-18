class Plant < ApplicationRecord
  has_many :plantings, dependent: :destroy
end
