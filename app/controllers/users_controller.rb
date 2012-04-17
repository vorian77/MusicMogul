class UsersController < ApplicationController
  respond_to :html
  
  before_filter :authenticate_user!
  
  def show
  end
  
  def update
    if current_user.update_attributes(params[:user])
      respond_with current_user, :location => account_path
    else
      respond_with current_user do |format|
        format.html { render :action => 'show' }
      end
    end
  end
  
end