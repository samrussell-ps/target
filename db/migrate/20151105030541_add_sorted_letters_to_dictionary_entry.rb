class AddSortedLettersToDictionaryEntry < ActiveRecord::Migration
  def change
    add_column :dictionary_entries, :sorted_letters, :string
  end
end
