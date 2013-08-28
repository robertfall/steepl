class SmsMessageService
  def self.send_message(message)
    instance = new
    instance.send_message(message)
  end

  def send_message(message)
    recipient_numbers = message.recipients.map {|r| r.adapter.mobile_numbers }.flatten.reject(&:nil?).map(&:international)
    Rails.logger.warn "Should Track SMS Sending"
    sms(recipient_numbers, message.body)
  end

  private
  def sms(number, msg)

    Sms.send_message(number, msg)
  end
end
