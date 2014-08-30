class JobAvailableEmailTextWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence {hourly}
  def perform(recycler_user_id)
    max_radius = 20 # set the notification radius
    user = User.find(recycler_user_id)
    redeemers_within_max_radius = User.near([user.latitude, user.longitude], max_radius).where(function: "redeemer")

    redeemers_within_max_radius.each do |near_redeemer|
      if user.distance_from([near_redeemer.latitude, near_redeemer.longitude]) <= near_redeemer.radius
        ############ Transaction Created ##############
        # send all redeemers within their radius an alert that a job has been posted
        Hi5Mailer.job_available(near_redeemer).deliver
        # send text message alert
        message = "Shaka! #{near_redeemer.first_name}, a recycle job has just been posted in your area.
        Questions, contact Annie at hi5exchange@gmail.com."
        send_text(message, near_redeemer.phone ) if !near_redeemer.phone.empty?
        puts "@@@@@@@@@@@@@@@@@@@@@@@@@@ distance #{near_redeemer.first_name} is : #{user.distance_from([near_redeemer.latitude, near_redeemer.longitude])}"
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