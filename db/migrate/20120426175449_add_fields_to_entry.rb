class AddFieldsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :artist_type, :string
    add_column :entries, :genre, :string
    add_column :entries, :community_name, :string
    add_column :entries, :audition_type, :string
    add_column :entries, :song_title, :string
    add_column :entries, :written_by, :string
    add_column :entries, :performance_video, :string
    add_column :entries, :gift_name, :string
    add_column :entries, :gift_description, :string
    add_column :entries, :gift_value, :string
    add_column :entries, :kickstarter, :string
    add_column :entries, :pledgemusic, :string
  end
end
