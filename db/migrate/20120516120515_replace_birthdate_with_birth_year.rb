class ReplaceBirthdateWithBirthYear < ActiveRecord::Migration
  def up
    add_column :users, :birth_year, :string
    remove_column :users, :birthdate
  end

  def down
    remove_column :users, :birth_year
    add_column :users, :birthdate, :datetime
  end
end
