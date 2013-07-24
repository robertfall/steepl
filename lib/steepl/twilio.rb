module Steepl
  class Twilio
    def send_sms(mobile_phone, body)
      if Rails.env.development?
        puts <<-END
Sending #{body} to #{mobile_phone}
END
      else
        @twilio_client = ::Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_SECRET

        @twilio_client.account.sms.messages.create(
          :from => TWILIO_SENDER,
          :to => mobile_phone,
          :body => body
        )
      end
    end

    def make_otp_call(mobile_phone, handler_url)
      if Rails.env.development?
        puts <<-END
Calling #{mobile_phone}
END
      else
        @twilio_client = ::Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_SECRET
        @call = @twilio_client.account.calls.create(
          :from => TWILIO_SENDER,
          :to => mobile_phone,
          :url => handler_url
        )
      end
    end
  end
end
