class ApplicationController < ActionController::Base
  protect_from_forgery

  respond_to :html, :json

  def authenticate_admin!
    authenticate_user!
    redirect_to new_user_session_path unless current_user.admin?
  end

  protected

  # Move this into an initializer at some point
  def ayah
    AYAH::Integration.new('dee41a5e77683c9ce6f6a330802589d686a52aa8','a0c6c6f2c710ea765936d3cdbfbcab5fbab5982c')
  end

end
