class RegistrationsController < Devise::RegistrationsController
  def new
    resource = build_resource({})
    resource.musician = session[:musician] = params[:type] == "musician"
    respond_with resource
  end

  def create
    build_resource
    resource.invitation_token = session[:referral_token] if session[:referral_token].present?
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def after_inactive_sign_up_path_for(resource)
    verify_email_path
  end
end