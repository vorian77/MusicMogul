class EntriesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @entry = Entry.find params[:id]
    @judging = current_user.judgings.where(entry_id: @entry.id).first || @entry.judgings.new
  end

  def create
    @user = current_user
    @entry = current_user.entries.new(params[:entry])
    if @entry.save
      redirect_to account_path
    else
      render "users/edit"
    end
  end

  def update
    @user = current_user
    @entry = current_user.entries.find(params[:id])
    if @entry.update_attributes(params[:entry])
      redirect_to account_path
    else
      render "users/edit"
    end
  end

  def leaderboard
    @entries = Entry.order("points desc")
  end
end