class HomeController < ApplicationController
  def index
    if user_signed_in?
      @entries = Entry.with_contest.finished.unevaluated_by(current_user).order("random()")
      @entries = @entries.unexplicit unless current_user.show_explicit_videos?
    else
      @entries = Entry.with_contest.finished.order("random()")
      @inviter = User.find_by_referral_token(session[:referral_token]) if session[:referral_token].present?
    end
  end
end
