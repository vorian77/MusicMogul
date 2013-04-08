class AddLeaderboardDisplayToContests < ActiveRecord::Migration
  def change
    add_column :contests, :leaderboard_display, :string
    remove_column :contests, :show_leaderboard
  end
end
