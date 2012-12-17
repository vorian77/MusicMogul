class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  before_filter :set_referral_token
  before_filter :redirect_entryless_musicians
  before_filter :perform_basic_authentication if Rails.env.staging?

  unless Rails.configuration.consider_all_requests_local
    rescue_from Exception, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActionController::UnknownController, with: :render_not_found
    rescue_from ActionController::UnknownAction, with: :render_not_found
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:failure] = exception.message
    redirect_to main_app.root_url
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
    if devise_controller? || [verify_email_path, new_entry_path, entries_path].include?(request.fullpath)
      "login"
    else
      "application"
    end
  end

  private

  def perform_basic_authentication
    authenticate_or_request_with_http_basic do |username, password|
      username == "mogul" && password == "detroit1"
    end
  end

  def set_referral_token
    session[:referral_token] = params[:referral_token] if params[:referral_token].present?
  end

  def redirect_entryless_musicians
    return if [new_entry_path, entries_path].include? request.fullpath
    if user_signed_in? && current_user.confirmed? && current_user.musician? && current_user.entries.count == 0
      redirect_to new_entry_path
    end
  end

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
