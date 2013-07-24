class SmsMessageService
  def self.send_message(message)
    instance = new
    instance.send_message(message)
  end

  def send_message(message)
    recipient_numbers = message.recipients.map {|r| r.adapter.mobile_numbers }.flatten.map(&:international)

    Rails.logger.warn "Should Track SMS Sending"

    recipient_numbers.each do |number|
      binding.pry
      sms(number, message.body)
    end
  end

  private
  def sms(number, msg)
    TWILIO.send_sms(number, msg)
  end
end
