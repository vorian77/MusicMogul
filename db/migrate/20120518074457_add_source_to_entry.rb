class AddSourceToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :source, :string
  end
end
