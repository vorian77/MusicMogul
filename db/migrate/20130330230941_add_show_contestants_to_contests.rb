class AddShowContestantsToContests < ActiveRecord::Migration
  def change
    add_column :contests, :show_contestants, :boolean, default: false
  end
end
