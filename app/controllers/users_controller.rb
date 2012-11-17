class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :reset_password
  
  def edit
    @user = current_user
    @entry = current_user.entries.first || current_user.entries.new
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      @entry = current_user.entries.first || current_user.entries.new
      redirect_to account_path
    else
      @entry = current_user.entries.first || current_user.entries.new
      render :edit
    end
  end

  def reset_password
    user = User.find_by_email(params[:user][:email])
    user.send_reset_password_instructions if user
    redirect_to root_path, :notice => 'A password reset email has been sent.'
  end
end
