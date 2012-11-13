class AddOverallScoreToJudgings < ActiveRecord::Migration
  def change
    add_column :judgings, :overall_score, :integer
  end
end
