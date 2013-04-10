class AddArtistSignUpEndDateToContests < ActiveRecord::Migration
  def change
    add_column :contests, :artist_sign_up_end_date, :datetime
  end
end
