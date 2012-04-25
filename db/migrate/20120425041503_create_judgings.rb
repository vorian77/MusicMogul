class CreateJudgings < ActiveRecord::Migration
  def change
    create_table :judgings do |t|
      t.references :contest
      t.references :user

      t.timestamps
    end
    add_index :judgings, :contest_id
    add_index :judgings, :user_id
  end
end
