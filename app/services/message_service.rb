class MessageService
  def self.send_message(message)
    instance = new
    instance.send_message(message)
  end

  def send_message(message)
    case message.message_type

    when Message::SMS
      SmsMessageService.send_message(message)
      message.update_column(:sent_at, Time.zone.now)
    when Message::EMAIL
      MessageMailer.message_mail(message).deliver
      message.update_column(:sent_at, Time.zone.now)
    end
  end
end
