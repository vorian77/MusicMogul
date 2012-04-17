class AddProfileFieldsToUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :zip
      t.string :country
      t.date :birthdate
      t.boolean :interview_status
      t.string :profile_name
      t.string :hometown
      t.string :genre
      t.string :bio
      t.string :profile_video
      t.string :performance_video
      t.string :profile_photo_square
      t.string :profile_photo_rectangle
      t.string :facebook
      t.string :twitter
    end
  end
end
