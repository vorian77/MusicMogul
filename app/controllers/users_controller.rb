class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def edit
    current_user.profile_video.success_action_redirect = s3_callback_url
  end
  
  def update
    ['landscape','square'].each do |type|
      params[:user]["remove_profile_photo_#{type}".to_sym] = nil if params[:user] && params[:user]["profile_photo_#{type}".to_sym]
    end
    respond_with current_user do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to account_path, :notice => 'Your account has been successfully saved' }
        format.json { render :json => { :notice => 'Your account has been successfully saved' } }
      else
        format.html { render :action => 'edit', :alert => 'Sorry, there was an error in the form' }
        format.json { render :json => { :errors => current_user.errors }, :status => :unprocessable_entity }
      end
    end
  end
  
  def s3_callback
    raise unless params[:key]
    current_user.key = params[:key]
    current_user.save(:validate => false)
    render :nothing => true
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

  def upload
  end

end
