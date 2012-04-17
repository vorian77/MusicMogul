class RemoveGenreFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :genre
  end

  def down
    add_column :users, :genre, :string
  end
end
