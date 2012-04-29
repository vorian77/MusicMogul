class UsersController < ApplicationController
  respond_to :html
  
  before_filter :authenticate_user!
  
  def edit
  end
  
  def update
    ['landscape','square'].each do |type|
      params[:user]["remove_profile_photo_#{type}".to_sym] = nil if params[:user]["profile_photo_#{type}".to_sym]
    end
    params[:user]
    if current_user.update_attributes(params[:user])
      respond_with current_user, :location => account_path
    else
      respond_with current_user do |format|
        format.html { render :action => 'show' }
      end
    end
  end
  
  def edit_thumbnail
    render 'edit_thumbnail', :layout => 'basic'
  end

  def update_thumbnail
    current_user.tap do |u|
      u.thumb_x = params[:user][:thumb_x]
      u.thumb_y = params[:user][:thumb_y]
      u.thumb_w = params[:user][:thumb_w]
    end
    current_user.profile_photo_square.recreate_versions!
    render :nothing => true
  end

end
