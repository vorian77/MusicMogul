class AddDefaultToSocialAccountsOnEntries < ActiveRecord::Migration
  def change
    change_column :entries, :facebook, :string, default: "http://www.facebook.com/"
    change_column :entries, :twitter, :string, default: "http://www.twitter.com/"
    change_column :entries, :youtube, :string, default: "http://www.youtube.com/"
    change_column :entries, :pinterest, :string, default: "http://www.pinterest.com/"
    change_column :entries, :website, :string, default: "http://"
  end
end
