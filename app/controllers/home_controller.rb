class HomeController < ApplicationController
  def index
    @entries = if user_signed_in?
                 Entry.unevaluated_by(current_user).order("random()")
               else
                 Entry.order("random()")
               end
  end

  def video
    render 'video', :layout => 'basic'
  end
end
