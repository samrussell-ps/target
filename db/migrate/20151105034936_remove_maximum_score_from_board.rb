class RemoveMaximumScoreFromBoard < ActiveRecord::Migration
  def change
    remove_column :boards, :maximum_score, :integer
  end
end
