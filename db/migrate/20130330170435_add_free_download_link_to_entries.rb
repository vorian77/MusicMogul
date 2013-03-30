class AddFreeDownloadLinkToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :free_download_link, :string
  end
end
