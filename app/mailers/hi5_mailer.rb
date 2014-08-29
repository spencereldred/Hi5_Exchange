class Hi5Mailer < ActionMailer::Base
  default from:  "eldredspencer@gmail.com"

  def welcome_redeemer(user)
    @user = user
    @greeting = "Aloha"
    # need to change this to the heroku site
    @url = 'http://localhost:3000/sessions/new' # the web site url, for a link to login to your site
    mail(to: @user.email, subject: 'Welcome to Hi5 Exchange')
  end

  def welcome_recycler(user)
    @user = user
    @greeting = "Aloha"
    # need to change this to the heroku site
    @url = 'http://localhost:3000/sessions/new' # the web site url, for a link to login to your site
    mail(to: @user.email, subject: 'Welcome to Hi5 Exchange')
  end

  def selected(user)
    @user = user
    @greeting = "Aloha"

    mail(to: @user.email, subject: 'Hi5 Exchange: Recycle job has been selected')
  end

  def profile_updated(user)
    @user = user
    @greeting = "Aloha"

    mail(to: @user.email, subject: 'Hi5 Exchange: Profile updated.')
  end

end
