class ChangePointsOnEntriesToFloat < ActiveRecord::Migration
  def change
    change_column :entries, :points, :float
  end
end
