class ContactMailer < ActionMailer::Base
  def contact(params)
    @name = params[:name]
    @from = params[:email]
    @subject = params[:subject]
    @message = params[:message]

    options = {to: "contact@MusicMogul.com",
               from: @from,
               subject: "Contact Us: #{@subject}"}
    options[:cc] = @from if params[:send_me_a_copy] == "1"

    mail(options)
  end
end
