class AddPromptToJournalEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :journal_entries, :prompt, :text
  end
end
