class WelcomeMailer < ActionMailer::Base
  default from: "musicmogul-noreply@musicmogul.com"

  def new_artist(user)
    if email = SiteConfiguration.musician_welcome_email
      @user = user
      @body = email.body
      mail(to: user.email,
           subject: email.subject)
    end
  end

  def new_fan(user)
    if email = SiteConfiguration.fan_welcome_email
      @user = user
      @body = email.body
      mail(to: user.email,
           subject: email.subject)
    end
  end
end