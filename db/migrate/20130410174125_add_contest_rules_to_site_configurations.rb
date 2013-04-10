class AddContestRulesToSiteConfigurations < ActiveRecord::Migration
  def change
    add_column :site_configurations, :contest_rules, :text
  end
end
