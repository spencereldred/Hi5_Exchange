class JobAvailableEmailTextWorker
  include Sidekiq::Worker

  def perform(recycler_user_id)
    max_radius = 20 # set the notification radius
    user = User.find(recycler_user_id)
    user_profile = user.profile
    profiles_within_max_radius = Profile.near([user.profile.latitude, user.profile.longitude], max_radius).where(function: "redeemer")

    profiles_within_max_radius.each do |profile|
      if user_profile.distance_from([profile.latitude, profile.longitude]) <= profile.radius
        ############ Transaction Created ##############
        # send all redeemers within their radius an alert that a job has been posted
        Hi5Mailer.job_available(profile.user).deliver
        # send text message alert
        message = "Shaka! #{profile.first_name}, a recycle job has just been posted in your area.
        Questions, contact Annie at hi5exchange@gmail.com."
        send_text(message, profile.phone ) if !profile.phone.empty?
        puts "@@@@@@@@@@@@@@@@@@@@@@@@@@ distance #{profile.first_name} is : #{user_profile.distance_from([profile.latitude, profile.longitude])}"
      end
    end
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