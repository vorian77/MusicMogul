class DropUnusedColumns < ActiveRecord::Migration
  def change
    remove_column :entries, :contest_id
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :zip
    remove_column :users, :country
    remove_column :users, :interview_status
    remove_column :users, :bio
    remove_column :users, :profile_video
    remove_column :users, :performance_video
    remove_column :users, :profile_photo_square
    remove_column :users, :profile_photo_landscape
    remove_column :users, :facebook
    remove_column :users, :twitter
    remove_column :users, :phone
    remove_column :users, :youtube
    remove_column :users, :genre
    remove_column :users, :birth_year
    remove_column :users, :thumb_x
    remove_column :users, :thumb_y
    remove_column :users, :thumb_w
    remove_column :users, :youtube_url
    remove_column :users, :provider
    remove_column :users, :uid
  end
end
