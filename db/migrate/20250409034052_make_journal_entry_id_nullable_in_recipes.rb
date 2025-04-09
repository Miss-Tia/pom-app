class MakeJournalEntryIdNullableInRecipes < ActiveRecord::Migration[8.0]
  def change
    change_column_null :recipes, :journal_entry_id, true
  end
end
