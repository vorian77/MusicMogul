class RenameLegacyColumns < ActiveRecord::Migration
  def change
    rename_column :entries, :community_name, :stage_name
    rename_column :entries, :song_title, :title
    rename_column :users, :profile_name, :player_name
  end
end
