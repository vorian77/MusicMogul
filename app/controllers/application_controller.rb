class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  unless Rails.configuration.consider_all_requests_local
    rescue_from Exception, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActionController::UnknownController, with: :render_not_found
    rescue_from ActionController::UnknownAction, with: :render_not_found
  end

  def authenticate_admin!
    authenticate_user!
    redirect_to new_user_session_path unless current_user.admin?
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  private

  def render_not_found(e)
    Airbrake.notify e
    respond_to do |format|
      format.html { render template: "errors/404", status: 404 }
      format.all { render nothing: true, status: 404 }
    end
    true
  end

  def render_error(e)
    Airbrake.notify e
    respond_to do |format|
      format.html { render template: "errors/500", status: 500 }
      format.all { render nothing: true, status: 500 }
    end
    true
  end
end
