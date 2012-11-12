class HomeController < ApplicationController
  def index
    @entries = Entry.order("random()")
  end

  def video
    render 'video', :layout => 'basic'
  end
end
