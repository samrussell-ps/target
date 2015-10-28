class CreateSubmittedWords < ActiveRecord::Migration
  def change
    create_table :submitted_words do |t|
      t.integer :dictionary_entry_id
      t.integer :board_id

      t.timestamps null: false
    end
  end
end
