class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  def authenticate_admin!
    authenticate_user!
    redirect_to new_user_session_path unless current_user.admin?
  end

  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end
