class RenameDictionaryEntriesToDictionaryWords < ActiveRecord::Migration
  def change
    rename_table :dictionary_entries, :dictionary_words
    rename_column :boards, :dictionary_entry_id, :dictionary_word_id
    rename_column :submitted_words, :dictionary_entry_id, :dictionary_word_id
  end
end
