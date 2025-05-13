class Planting < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
end
