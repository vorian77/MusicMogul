class SessionsController < Devise::SessionsController
  prepend_before_filter :load_user, only: :create

  private

  def load_user
    user = User.find_by_email(params[:user][:email].try(:strip).try(:downcase))
    if user.present?
      session[:musician] = user.musician
      user.send_confirmation_instructions unless user.confirmed?
    end
  end
end