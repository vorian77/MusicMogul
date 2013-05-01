class CreateCampaignLinks < ActiveRecord::Migration
  def change
    create_table :campaign_links do |t|
      t.string :token
      t.string :shortened_link
      t.string :description
      t.timestamps
    end
  end
end
