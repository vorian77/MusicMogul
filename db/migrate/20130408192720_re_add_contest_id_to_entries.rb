class ReAddContestIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :contest_id, :integer
    add_index :entries, :contest_id
  end
end
