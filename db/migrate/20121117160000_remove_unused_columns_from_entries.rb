class RemoveUnusedColumnsFromEntries < ActiveRecord::Migration
  def change
    remove_column :entries, :active
    remove_column :entries, :artist_type
    remove_column :entries, :audition_type
    remove_column :entries, :written_by
    remove_column :entries, :performance_video
    remove_column :entries, :gift_name
    remove_column :entries, :gift_description
    remove_column :entries, :gift_value
    remove_column :entries, :kickstarter
    remove_column :entries, :pledgemusic
    remove_column :entries, :source
  end
end
