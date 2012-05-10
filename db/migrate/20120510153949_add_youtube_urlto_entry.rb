class AddYoutubeUrltoEntry < ActiveRecord::Migration
  def up
    add_column :entries, :youtube_url, :string
  end

  def down
    remove_column :entries, :youtube_url, :string
  end
end
