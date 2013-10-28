class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_tokens
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

  private

  def ensure_contest_running!
    redirect_to root_path unless Contest.active.present?
  end

  def perform_basic_authentication
    authenticate_or_request_with_http_basic do |username, password|
      (username == "mogul" || username == "truste") && password == "detroit1"
    end
  end

  def set_tokens
    session[:referral_token] = params[:referral_token] if params[:referral_token].present?
    session[:campaign_token] = params[:campaign_token] if params[:campaign_token].present?
  end

  def redirect_entryless_musicians
    return if [finish_entry_path].include? request.fullpath
    if user_signed_in? && current_user.confirmed? && current_user.musician? && current_user.entries.finished.count == 0
      redirect_to finish_entry_path
    end
  end

  def render_not_found(e)
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
