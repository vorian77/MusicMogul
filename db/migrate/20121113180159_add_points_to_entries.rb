class AddPointsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :points, :integer, default: 0
  end
end
