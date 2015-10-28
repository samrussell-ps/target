class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :dictionary_entry_id
      t.integer :word_shuffle_seed

      t.timestamps null: false
    end
  end
end
