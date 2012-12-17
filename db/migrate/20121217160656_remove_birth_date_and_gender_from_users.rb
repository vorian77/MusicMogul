class RemoveBirthDateAndGenderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birth_date
    remove_column :users, :gender
  end
end
