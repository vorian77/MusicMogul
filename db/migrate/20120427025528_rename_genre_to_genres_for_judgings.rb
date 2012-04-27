class RenameGenreToGenresForJudgings < ActiveRecord::Migration
  def up
    rename_column :judgings, :genre, :genres
  end

  def down
    rename_column :judgins, :genres, :genre
  end
end
