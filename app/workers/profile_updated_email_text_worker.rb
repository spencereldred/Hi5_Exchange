class ProfileUpdatedEmailTextWorker
  include Sidekiq::Worker

  def perform(user)
    # user = User.find(user_id)
    Hi5Mailer.profile_updated(user).deliver
    message = "Shaka! #{user.profile.first_name}, your profile has been updated.
    Questions, contact Annie at hi5exchange@gmail.com."
    send_text(message, user.profile.phone ) if !user.profile.phone.empty?
  end

  # Sends text message using Twilio's service
  def send_text(text, phone)
    account_sid    = ENV["ACCOUNT_SID"]
    auth_token     = ENV["AUTH_TOKEN"]
    client = Twilio::REST::Client.new account_sid, auth_token

    account = client.account
    message = account.sms.messages.create({
      :from => ENV["PHONE"],
      :to => phone,
      :body => text})
    puts message
  end
end