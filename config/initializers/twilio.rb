TWILIO_ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
TWILIO_SECRET = ENV["TWILIO_SECRET"]
TWILIO_SENDER = ENV["TWILIO_SENDER"]

unless Rails.env.test?
  TWILIO = Steepl::Twilio.new
end