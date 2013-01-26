class ChangeScoreColumnsToFloats < ActiveRecord::Migration
  def change
    change_column :evaluations, :music_score, :float
    change_column :evaluations, :vocals_score, :float
    change_column :evaluations, :presentation_score, :float
  end
end
