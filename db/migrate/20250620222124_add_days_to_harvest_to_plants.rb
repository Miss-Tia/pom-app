class AddDaysToHarvestToPlants < ActiveRecord::Migration[8.0]
  def change
    add_column :plants, :days_to_harvest, :integer
  end
end
