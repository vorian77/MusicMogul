class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:verify_email]
  load_and_authorize_resource except: [:verify_email]

  def update
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(current_user)
    else
      render :edit
    end
  end
end
