class Hi5Mailer < ActionMailer::Base
  default from:  "eldredspencer@gmail.com"

  def profile_updated(user)
    @user = user
    @greeting = "Aloha"

    mail(to: @user.email, subject: 'Hi5 Exchange: Profile updated.')
  end

end
