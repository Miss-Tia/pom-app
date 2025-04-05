class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :ingredients
      t.text :instructions
      t.references :user, null: false, foreign_key: true
      t.references :journal_entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
