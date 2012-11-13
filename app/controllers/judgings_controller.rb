class JudgingsController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @judging = current_user.judgings.new(params[:judging].merge(entry_id: @entry.id))
    if @judging.save
      redirect_to @entry
    else
      render "entries/show"
    end
  end
end