class AddIndexToDictionaryEntryWord < ActiveRecord::Migration
  def change
    add_index :dictionary_entries, :word
  end
end
