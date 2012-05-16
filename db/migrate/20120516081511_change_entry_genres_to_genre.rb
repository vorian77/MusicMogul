class ChangeEntryGenresToGenre < ActiveRecord::Migration
  def up
    add_column :entries, :genre, :string
    remove_column :entries, :genres
  end

  def down
    remove_column :entries, :genre
    add_column :entry, :genres, :string
  end
end
