class TransactionUpdateEmailTextWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence {hourly}
  def perform(trans_id)
      trans = Transaction.find(trans_id)
      user = User.find(trans.recycler_user_id)
      puts "#{user.first_name} - Email"

      if trans.completed == true && trans.selected == true
        ############ COMPLETED ##############
        # send recycler email that the redeemer indicates the job is done
        Hi5Mailer.completed(user).deliver
        # send recycler a text message
        message = "Shaka! #{user.first_name}, our records indicate your recycling has been picked up.
        If this is not true, please contact Annie at hi5exchange@gmail.com."
        send_text(message, user.phone ) if !user.phone.empty?
      end

      if trans.completed == false && trans.selected == true
        ############ SELECTED ##############
        # send recycler an email that states a redeemer has claimed the job
        Hi5Mailer.selected(user).deliver
        # send recycler a text message
        message = "Shaka! #{user.first_name}, a redeemer will swing by within 24 hours, so please make sure your items are already out for pickup.
-Annie at hi5exchange@gmail.com"
        send_text(message, user.phone) if !user.phone.empty?
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