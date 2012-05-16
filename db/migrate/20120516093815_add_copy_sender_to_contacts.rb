class AddCopySenderToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :copy_sender, :boolean
  end
end
