class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :except => :reset_password
  
  def edit
  end
  
  def update
    ['landscape','square'].each do |type|
      params[:user]["remove_profile_photo_#{type}".to_sym] = nil if params[:user] && params[:user]["profile_photo_#{type}".to_sym]
    end
    respond_with current_user do |format|
      if current_user.update_attributes(params[:user])
        sign_in(current_user, :bypass => true) if params[:user] && params[:user][:password]
        notice = current_user.pending_reconfirmation? ? 'Your new email address is pending confirmation' : 'Your account has been successfully saved'
        format.html { redirect_to account_path, :notice => notice }
        format.json { render :json => { :notice => notice } }
      else
        format.html { render :action => 'edit', :alert => 'Sorry, there was an error in the form' }
        format.json { render :json => { :errors => current_user.errors }, :status => :unprocessable_entity }
      end
    end
  end
  
  def create_profile_photo
    raise unless params[:s3_key]
    current_user.remote_profile_photo_square_url = "https://s3.amazonaws.com/fanhelp.mvp/#{params[:s3_key]}"
    current_user.save(:validate => false)
    render :nothing => true
  end

  def remove_profile_photo
    current_user.remove_profile_photo_square = '1'
    current_user.save(:validate => false)
    render :nothing => true
  end

  def create_profile_video
    raise unless params[:s3_key]
    current_user.update_attribute(:profile_video,params[:s3_key])
    render :nothing => true
  end
  
  def remove_profile_video
    current_user.profile_video = nil
    current_user.youtube_url = nil
    current_user.save(:validate => false)
    render :nothing => true
  end

  def create_entry_performance_video
    raise unless params[:s3_key]
    puts params.inspect
    puts current_user.entry.update_attribute(:performance_video,params[:s3_key])
    puts current_user.entry.inspect
    render :nothing => true
  end

  def remove_entry_performance_video
    entry = current_user.entry
    entry.performance_video = nil
    entry.youtube_url = nil
    entry.save(:validate => false)
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
      u.save(:validate => false)
    end
    current_user.profile_photo_square.recreate_versions!
    render :nothing => true
  end

  def upload
  end

  def reset_password
    user = User.find_by_email(params[:user][:email])
    user.send_reset_password_instructions if user
    redirect_to root_path, :notice => 'A password reset email has been sent.'
  end

end
