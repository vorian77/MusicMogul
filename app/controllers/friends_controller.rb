class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @invited_users = current_user.invited_users.includes(:entries).order("created_at")
    @entry = current_user.entries.first if current_user.entries.present?
  end
end