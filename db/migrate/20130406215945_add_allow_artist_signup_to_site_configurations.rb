class AddAllowArtistSignupToSiteConfigurations < ActiveRecord::Migration
  def change
    add_column :site_configurations, :allow_artist_signup, :boolean, default: false
  end
end
