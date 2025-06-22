class ChangeProgressNotesToJsonbInPlantings < ActiveRecord::Migration[8.0]
    def up
  change_column :plantings, :progress_notes, :jsonb, default: []
    end

def down
  change_column :plantings, :progress_notes, :text
end
end
