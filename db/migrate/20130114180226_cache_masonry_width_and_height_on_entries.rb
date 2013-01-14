class CacheMasonryWidthAndHeightOnEntries < ActiveRecord::Migration
  def change
    add_column :entries, :masonry_width, :integer
    add_column :entries, :masonry_height, :integer
  end
end
