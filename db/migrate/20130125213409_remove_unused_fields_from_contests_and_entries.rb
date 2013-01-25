class RemoveUnusedFieldsFromContestsAndEntries < ActiveRecord::Migration
  def change
    remove_column :contests, :name
    remove_column :entries, :contest_id
  end
end
