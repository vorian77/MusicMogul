class AddLeaderboardMaxRanksToSiteConfigurations < ActiveRecord::Migration
  def change
    add_column :site_configurations, :leaderboard_max_contestant_rank, :integer, default: 0
    add_column :site_configurations, :leaderboard_max_mogul_rank, :integer, default: 0
  end
end
