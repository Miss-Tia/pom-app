class AddPlantedOnToPlantings < ActiveRecord::Migration[8.0]
  def change
    add_column :plantings, :planted_on, :date
  end
end
