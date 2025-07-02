class RemovePlantedOnFromPlantings < ActiveRecord::Migration[8.0]
  def change
    remove_column :plantings, :planted_on, :date
  end
end
