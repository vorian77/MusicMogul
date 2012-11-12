class AddHometownAndBioToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :hometown, :string
    add_column :entries, :bio, :text
  end
end
