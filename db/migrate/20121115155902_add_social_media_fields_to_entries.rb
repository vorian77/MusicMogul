class AddSocialMediaFieldsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :facebook, :string
    add_column :entries, :twitter, :string
    add_column :entries, :youtube, :string
    add_column :entries, :pinterest, :string
    add_column :entries, :website, :string
  end
end
