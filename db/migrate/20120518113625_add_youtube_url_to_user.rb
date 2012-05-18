class AddYoutubeUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :youtube_url, :string
  end
end
