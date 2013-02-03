class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:verify_email]
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
    @musicians = User.musician.sort_by(&:points).reverse
    @fans = User.fan.sort_by(&:points).reverse
  end

  def scorecard
    render json: {scorecard: render_to_string(partial: "users/score")}
  end
end
