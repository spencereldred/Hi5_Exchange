class TransactionUpdateEmailTextWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence {hourly}
  def perform(recyclable_id)
      binding.pry
      recyclable = Recyclable.find(recyclable_id)
      binding.pry
      user = User.find(recyclable.users[0].id)
      puts "#{user.profile.first_name} - Email"

      if recyclable.completed == true && recyclable.selected == true
        ############ COMPLETED ##############
        # send recycler email that the redeemer indicates the job is done
        Hi5Mailer.completed(user).deliver
        # send recycler a text message
        message = "Shaka! #{user.profile.first_name}, our records indicate your recycling has been picked up.
        If this is not true, please contact Annie at hi5exchange@gmail.com."
        send_text(message, user.profile.phone ) if !user.profile.phone.empty?
      end

      if recyclable.completed == false && recyclable.selected == true
        ############ SELECTED ##############
        # send recycler an email that states a redeemer has claimed the job
        Hi5Mailer.selected(user).deliver
        # send recycler a text message
        message = "Shaka! #{user.profile.first_name}, a redeemer will swing by within 24 hours, so please make sure your items are already out for pickup.
-Annie at hi5exchange@gmail.com"
        send_text(message, user.profile.phone) if !user.profile.phone.empty?
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