class FollowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    current_user.follows.create(entry_id: params[:entry_id])
    render nothing: true
  end

  def destroy
    current_user.follows.find_by_entry_id(params[:entry_id]).try(:destroy)
    render nothing: true
  end
end