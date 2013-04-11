class AddNextContestStartDateToSiteConfigurations < ActiveRecord::Migration
  def change
    add_column :site_configurations, :next_contest_start_date, :datetime
  end
end
