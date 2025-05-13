class AddLocationToPlantings < ActiveRecord::Migration[8.0]
  def change
    add_column :plantings, :location, :string
  end
end
