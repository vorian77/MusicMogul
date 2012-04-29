class RenameGenreToGenresInEntries < ActiveRecord::Migration
  def up
    rename_column :entries, :genre, :genres
  end

  def down
    rename_column :entries, :genres, :genre
  end
end
