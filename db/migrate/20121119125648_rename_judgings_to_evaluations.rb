class RenameJudgingsToEvaluations < ActiveRecord::Migration
  def change
    rename_table :judgings, :evaluations
  end
end
