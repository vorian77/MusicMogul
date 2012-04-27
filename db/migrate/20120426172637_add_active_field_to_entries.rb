class AddActiveFieldToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :active, :boolean, :default => false, :null => false
  end
end
