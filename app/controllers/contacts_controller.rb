class ContactsController < ApplicationController
  def create
    if contact_complete?
      ContactMailer.contact(params[:contact]).deliver
      redirect_to notices_path(anchor: "contact"), notice: "Successfully sent!"
    else
      redirect_to notices_path(anchor: "contact"), notice: "Could not send."
    end
  end

  private

  def contact_complete?
    [:name, :email, :subject, :message].all? do |attribute|
      params[:contact][attribute].present?
    end
  end
end