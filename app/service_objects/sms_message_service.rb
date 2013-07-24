class SmsMessageService
  def self.send_message(message)
    instance = new
    instance.send_message(message)
  end

  def send_message(message)
    recepient_numbers = message.recepients.map {|r| r.mobile_numbers }.flatten.map(&:full)

    Rails.logger.warn "Should Track SMS Sending"

    recepient_numbers.each do |number|
      sms(number, message.body)
    end
  end

  private
  def sms(number, msg)
    TWILIO.send_sms(number, msg)
  end
end
