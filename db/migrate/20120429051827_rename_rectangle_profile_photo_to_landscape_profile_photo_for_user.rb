class RenameRectangleProfilePhotoToLandscapeProfilePhotoForUser < ActiveRecord::Migration
  def up
    rename_column :users, :profile_photo_rectangle, :profile_photo_landscape
  end

  def down
    rename_column :users, :profile_photo_landscape, :profile_photo_rectangle
  end
end
