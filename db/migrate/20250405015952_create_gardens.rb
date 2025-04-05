class CreateGardens < ActiveRecord::Migration[8.0]
  def change
    create_table :gardens do |t|
      t.string :name
      t.string :location
      t.text :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
