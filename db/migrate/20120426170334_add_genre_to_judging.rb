class AddGenreToJudging < ActiveRecord::Migration
  def change
    add_column :judgings, :genre, :string
  end
end
