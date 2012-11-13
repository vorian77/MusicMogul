class AddFieldsToJudgings < ActiveRecord::Migration
  def change
    add_column :judgings, :comment, :text
    add_column :judgings, :music_score, :integer
    add_column :judgings, :presentation_score, :integer
    add_column :judgings, :vocals_score, :integer
  end
end
