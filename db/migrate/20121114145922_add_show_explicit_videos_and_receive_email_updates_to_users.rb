class AddShowExplicitVideosAndReceiveEmailUpdatesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_explicit_videos, :boolean, default: true
    add_column :users, :receive_email_updates, :boolean, default: true
  end
end
