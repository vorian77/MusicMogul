class RemoveUnusedColumnsFromJudgings < ActiveRecord::Migration
  def change
    remove_column :judgings, :contest_id
    remove_column :judgings, :active
    remove_column :judgings, :genres
  end
end
