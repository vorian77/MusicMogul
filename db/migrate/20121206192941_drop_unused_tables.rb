class DropUnusedTables < ActiveRecord::Migration
  def change
    drop_table :contacts
    drop_table :contests
  end
end
