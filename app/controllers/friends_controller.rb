class FriendsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @invited_users = current_user.invited_users.order("created_at")
  end
end