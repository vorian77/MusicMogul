class EvaluationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @evaluations = current_user.evaluations.includes(:entry).order("created_at desc")
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @evaluation = current_user.evaluations.new(params[:evaluation].merge(entry_id: @entry.id))
    if @evaluation.save
      redirect_to @entry
    else
      render "entries/show"
    end
  end
end