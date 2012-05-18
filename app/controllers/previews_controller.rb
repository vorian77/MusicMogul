class PreviewsController < ApplicationController

  def index
    if params[:genre]
      @artists = User.has_photo.genre(params[:genre]).all.sort_by {rand}
    else
      @artists = User.has_photo.all.sort_by {rand}
    end
  end
  
  def show
    @artist = User.find(params[:id])
    @next = User.has_photo.next(@artist).first
  end

end