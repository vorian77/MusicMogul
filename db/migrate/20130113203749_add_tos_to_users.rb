class AddTosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tos, :boolean
  end
end
