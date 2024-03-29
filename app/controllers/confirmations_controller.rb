class ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(resource_name, resource)
    resource.musician? ? finish_entry_path : root_path
  end
end