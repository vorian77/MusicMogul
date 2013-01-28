class FollowsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_contest_running!
  skip_before_filter :verify_authenticity_token

  def index
    @entries = current_user.followed_entries.order("random()")
  end

  def create
    current_user.follows.create(entry_id: params[:entry_id])
    render nothing: true
  end

  def destroy
    current_user.follows.find_by_entry_id(params[:entry_id]).try(:destroy)
    render nothing: true
  end
end