class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :user
      t.references :entry
      t.timestamps
    end

    add_index :contracts, :user_id
    add_index :contracts, :entry_id
  end
end
