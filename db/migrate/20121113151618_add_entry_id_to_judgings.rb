class AddEntryIdToJudgings < ActiveRecord::Migration
  def change
    add_column :judgings, :entry_id, :integer
    add_index :judgings, :entry_id
  end
end
