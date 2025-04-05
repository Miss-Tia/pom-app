class CreatePlants < ActiveRecord::Migration[8.0]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :variety
      t.text :notes
      t.date :planted_on
      t.date :last_watered_on
      t.date :last_fertilized_on
      t.date :harvested_on
      t.references :garden, null: false, foreign_key: true

      t.timestamps
    end
  end
end
