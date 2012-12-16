class AddMusicianToUsers < ActiveRecord::Migration
  def change
    add_column :users, :musician, :boolean, default: false
  end
end
