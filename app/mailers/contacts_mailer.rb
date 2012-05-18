class ContactsMailer < ActionMailer::Base
  default from: "phyl@fanhelp.us"

  def phyl_contact_email(contact)
    @contact = contact
    mail(:to => 'cory@corykaufman.com', :subject => '[FHA] Contact form submitted')
  end

  def sender_contact_email(contact)
    @contact = contact
    mail(:to => contact.email, :subject => '[FHA] Here\'s what you sent to Fans Helping Artists')
  end

end
