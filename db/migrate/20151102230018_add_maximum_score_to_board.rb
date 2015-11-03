class AddMaximumScoreToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :maximum_score, :integer
  end
end
