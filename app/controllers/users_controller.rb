class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:verify_email]
  before_filter :ensure_contest_running!, only: [:leaderboard]
  load_and_authorize_resource except: [:verify_email]

  def edit
    render current_user.fan? ? "mogul" : "musician"
  end

  def update
    respond_to do |format|
      format.html do
        if params[:user][:password].blank?
          params[:user].delete("password")
          params[:user].delete("password_confirmation")
        end
        if @user.update_attributes(params[:user])
          sign_in(@user, :bypass => true)
          redirect_to edit_user_path(current_user)
        else
          render current_user.fan? ? "mogul" : "musician"
        end
      end

      format.js do
        @user.assign_attributes(params[:user])
        if @user.save(validate: false)
          render json: @user.as_json(include: :entries)
        else
          render json: @user.errors
        end
      end
    end
  end

  def leaderboard
    respond_to do |format|
      format.html do
        @musicians = User.musician.order("cached_points desc").page(params[:page]).per(10)
        @fans = User.fan.order("cached_points desc")
      end
      format.js do
        if params[:musician_page].present?
          @musicians = User.musician.order("cached_points desc").page(params[:musician_page]).per(10)
          render json: {musicians: render_to_string(partial: "users/leaderboard/musicians", locals: {musicians: @musicians})}
        end
      end
    end
  end

  def scorecard
    render json: {scorecard: render_to_string(partial: "users/score")}
  end
end
