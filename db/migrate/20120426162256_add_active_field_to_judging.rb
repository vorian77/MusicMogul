class AddActiveFieldToJudging < ActiveRecord::Migration
  def change
    add_column :judgings, :active, :boolean, :default => false, :null => false
  end
end
