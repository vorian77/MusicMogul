class AddCachedPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cached_points, :integer, default: 0
  end
end
