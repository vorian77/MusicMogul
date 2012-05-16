class ContactsController < ApplicationController

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      respond_with @contact, :location => page_path('notices'), :notice => 'Your message was successfully sent'
    else
      flash[:alert] = 'Your message could not be sent'
      @ayah = ayah
      @contact_selected = true
      render 'pages/notices'
    end
  end

end
