class AddShowLeaderboardToContests < ActiveRecord::Migration
  def change
    add_column :contests, :show_leaderboard, :boolean, default: false
  end
end
