class ContactsController < ApplicationController

  def create
    @contact = Contact.new(params[:contact])

    session_secret = params['session_secret']
    ayah_passed = ayah.score_result(session_secret, request.remote_ip)

    if ayah_passed && @contact.save
      ContactsMailer.phyl_contact_email(@contact).deliver
      ContactsMailer.sender_contact_email(@contact).deliver if @contact.copy_sender?
      flash[:notice] = 'Your message was successfully sent'
      respond_with @contact, :location => page_path('notices', :anchor => 'tab-6')
    else
      if !ayah_passed
        flash[:alert] = 'Are You A Human verification failed. Please try again'
      else
        flash[:alert] = 'Your message could not be sent'
      end
      @ayah = ayah
      @contact_selected = true
      render 'pages/notices'
    end
  end

end
