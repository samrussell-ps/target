class CreateDictionaryEntries < ActiveRecord::Migration
  def change
    create_table :dictionary_entries do |t|
      t.string :word

      t.timestamps null: false
    end
  end
end
