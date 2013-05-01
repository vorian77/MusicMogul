class AddCampaignLinkIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :campaign_link_id, :integer
    add_index :users, :campaign_link_id
  end
end
