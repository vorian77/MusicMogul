class RenamePlayerNameToUsernameOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :player_name, :username
    add_index :users, :username, unique: true
  end
end
