class RemoveAllowArtistSignupFromSiteConfigurations < ActiveRecord::Migration
  def change
    remove_column :site_configurations, :allow_artist_signup
  end
end
