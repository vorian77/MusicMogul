class PreviewsController < ApplicationController

  def index
    if params[:genre].present?
      @artists = User.has_photo.has_entry.genre(params[:genre]).all.sort_by {rand}
    else
      @artists = User.has_photo.has_entry.all.sort_by {rand}
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @artist = User.find(params[:id])
    @next = User.has_photo.has_entry.next(@artist).first
  end

end