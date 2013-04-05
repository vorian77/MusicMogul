class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.belongs_to :user
      t.belongs_to :entry
      t.string :object
      t.timestamps
    end

    add_index :clicks, :user_id
    add_index :clicks, :entry_id
  end
end
