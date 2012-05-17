class AddCroppingFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :thumb_x, :integer
    add_column :users, :thumb_y, :integer
    add_column :users, :thumb_w, :integer
  end
end
