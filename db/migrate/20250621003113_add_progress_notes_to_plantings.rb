class AddProgressNotesToPlantings < ActiveRecord::Migration[8.0]
  def change
    add_column :plantings, :progress_notes, :text
  end
end
