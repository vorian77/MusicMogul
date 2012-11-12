class AddProfilePhotoToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :profile_photo, :string
  end
end
