class CreatePlantings < ActiveRecord::Migration[8.0]
  def change
    create_table :plantings do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :garden, null: false, foreign_key: true
      t.date :date_planted
      t.text :notes
      t.string :season

      t.timestamps
    end
  end
end
