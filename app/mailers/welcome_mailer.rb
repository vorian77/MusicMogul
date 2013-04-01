class WelcomeMailer < ActionMailer::Base
  default from: "musicmogul-noreply@musicmogul.com"

  def new_artist(user)
    @user = user
    mail(to: user.email,
         subject: "Welcome to Music Mogul!")
  end

  def new_fan(user)
    @user = user
    mail(to: user.email,
         subject: "Welcome to Music Mogul!")
  end
end