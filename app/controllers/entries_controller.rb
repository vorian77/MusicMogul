class EntriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
    @evaluation = current_user.evaluations.where(entry_id: @entry.id).first || @entry.evaluations.new
  end

  def create
    if @entry.save
      redirect_to root_path
    else
      render "entries/new"
    end
  end

  def update
    if @entry.update_attributes(params[:entry])
      redirect_to edit_entry_path(@entry)
    else
      render "entries/edit"
    end
  end

  def leaderboard
    @entries = Entry.where("points > 0").order("points desc")
  end
end