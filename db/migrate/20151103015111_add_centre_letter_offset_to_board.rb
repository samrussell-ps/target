class AddCentreLetterOffsetToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :centre_letter_offset, :integer
  end
end
