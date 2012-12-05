class EntriesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @entry = current_user.entries.new
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def show
    @entry = Entry.find params[:id]
    @evaluation = current_user.evaluations.where(entry_id: @entry.id).first || @entry.evaluations.new
  end

  def create
    @entry = current_user.entries.new(params[:entry])
    if @entry.save
      redirect_to edit_entry_path(@entry)
    else
      render "entries/new"
    end
  end

  def update
    @entry = current_user.entries.find(params[:id])
    if @entry.update_attributes(params[:entry])
      redirect_to edit_entry_path(@entry)
    else
      render "entries/new"
    end
  end

  def leaderboard
    @entries = Entry.where("points > 0").order("points desc")
  end
end