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