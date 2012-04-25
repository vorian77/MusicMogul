class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :contest
      t.references :user

      t.timestamps
    end
    add_index :entries, :contest_id
    add_index :entries, :user_id
  end
end
