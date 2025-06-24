class RemoveGardenIdFromPlants < ActiveRecord::Migration[8.0]
  def change
    remove_column :plants, :garden_id, :integer
  end
end
