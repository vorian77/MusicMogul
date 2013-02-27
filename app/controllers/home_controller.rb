class HomeController < ApplicationController
  def index
    if user_signed_in?
      @entries = Entry.finished.unevaluated_by(current_user).order("random()")
      @entries = @entries.unexplicit unless current_user.show_explicit_videos?
    else
      @entries = Entry.finished.order("random()")
      @inviter = User.find_by_referral_token(session[:referral_token]) if session[:referral_token].present?
      render layout: "landing"
    end
  end
end
