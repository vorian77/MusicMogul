class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :verify_email, :leaderboard]
  load_and_authorize_resource except: [:new, :verify_email, :leaderboard]

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
    redirect_to root_path unless Contest.first.try(:show_leaderboard_nav?)
    musician_ids = Entry.with_contest.finished.pluck(:user_id)
    @musicians = User.non_admin.where("id in (?)", musician_ids).order("cached_points desc, id")
    @fans = User.non_admin.fan.order("cached_points desc, id")
    if SiteConfiguration.leaderboard_max_contestant_rank != 0
      @musicians = @musicians.select do |user|
        show_leaderboard_row?(user.rank,
                              SiteConfiguration.leaderboard_max_contestant_rank,
                              current_user.try(:musician?) && current_user.try(:rank))
      end
    end
    if SiteConfiguration.leaderboard_max_mogul_rank != 0
      @fans = @fans.select do |user|
        show_leaderboard_row?(user.rank,
                              SiteConfiguration.leaderboard_max_mogul_rank,
                              current_user.try(:fan?) && current_user.try(:rank))
      end
    end
  end

  def my_data
    @user = current_user
    @entry = @user.entries.first
  end

  def fan_email_list
    @user = current_user
    @entry = @user.entries.first
    csv = CSV.generate({}) do |csv|
      csv << %w(username email)
      @entry.shared_email_users.each do |user|
        csv << [user.username, user.email]
      end
    end
    send_data csv, filename: "Music Mogul Fan List for #{@entry.stage_name} - #{Date.today.strftime("%y%m%d")}.csv"
  end

  def scorecard
    render json: {scorecard: render_to_string(partial: "users/score")}
  end

  private

  def show_leaderboard_row?(rank, max_rank, user_rank)
    (rank <= max_rank) || (user_rank && !user_rank.is_a?(String) && (rank - user_rank).abs <= 2)
  end
end
