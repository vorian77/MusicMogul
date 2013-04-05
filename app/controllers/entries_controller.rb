class EntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :ensure_contest_running!, except: [:finish]
  load_and_authorize_resource

  def finish
    @entry = current_user.entries.first
    if request.request_method == "PUT"
      respond_to do |format|
        format.html do
          if @entry.update_attributes(params[:entry])
            if @entry.finished?
              WelcomeMailer.new_artist(current_user).deliver
              redirect_to root_path
            else
              render "entries/finish"
            end
          end
        end
        format.js do
          @entry.assign_attributes(params[:entry])
          if @entry.save(validate: false)
            render json: @entry
          else
            render json: @entry.errors
          end
        end
      end
    end
  end

  def show
    current_user.clicks.create(entry_id: @entry.id, object: "Entry")
    @evaluation = current_user.evaluations.where(entry_id: @entry.id).first || @entry.evaluations.new
    @previous_entry = if @evaluation.new_record?
                        current_user.evaluations.order("created_at").last.try(:entry)
                      else
                        current_user.evaluations.order("created_at").where("created_at < ?", @evaluation.created_at).last.try(:entry)
    end
    @next_entry = Entry.unevaluated_by(current_user).where("entries.id != ?", @entry.id).order("random()").first
  end
end