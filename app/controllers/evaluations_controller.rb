class EvaluationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_contest_running!, except: [:index]

  def index
    if current_user.musician?
      @evaluations = current_user.entries.first.evaluations.includes(:user, :entry).order("created_at desc").page(params[:page]).per(10)
      respond_to do |format|
        format.html do
          render "musician"
        end
        format.js do
          render json: {index: render_to_string(partial: "evaluations/musicians", locals: {evaluations: @evaluations})}
        end
      end
    else
      @evaluations = current_user.evaluations.includes(:entry).order("created_at desc").page(params[:page]).per(10)
      respond_to do |format|
        format.html do
          render "mogul"
        end
        format.js do
          render json: {index: render_to_string(partial: "evaluations/moguls", locals: {evaluations: @evaluations})}
        end
      end
    end
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

  def update
    @evaluation = current_user.evaluations.find(params[:id])
    @evaluation.update_attributes(params[:evaluation])
    render nothing: true
  end
end