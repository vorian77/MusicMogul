class HomeController < ApplicationController
  def index
    if user_signed_in?
      @entries = Entry.unevaluated_by(current_user).order("random()")
      @entries = @entries.where(has_explicit_content: false) unless current_user.show_explicit_videos?
    else
      @entries = Entry.order("random()")
    end
  end

  def video
    render 'video', :layout => 'basic'
  end
end
