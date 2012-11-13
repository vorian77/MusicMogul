class EntriesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @entry = Entry.find params[:id]
    @judging = current_user.judgings.where(entry_id: @entry.id).first || @entry.judgings.new
  end
end