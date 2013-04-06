class CreateSiteConfigurations < ActiveRecord::Migration
  def change
    create_table :site_configurations do |t|
      t.integer :musician_welcome_email_id
      t.integer :fan_welcome_email_id
      t.timestamps
    end
  end
end
