class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name
      t.time :date

      t.timestamps
    end
  end
end
