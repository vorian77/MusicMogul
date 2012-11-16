class ChangeOverallScoreToFloatOnJudgings < ActiveRecord::Migration
  def change
    change_column :judgings, :overall_score, :float
  end
end
