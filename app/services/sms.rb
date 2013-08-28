class Sms
  def self.send_message(recipients, body)
    @instance = new
    @instance.send_message(recipients, body)
  end

  def send_message(recipients, body)
    recipients = recipients.join(',') if recipients.is_a? Array
    if Rails.env.production?
      api = Clickatell::API.authenticate(CLICKATELL_API_ID, CLICKATELL_USERNAME, CLICKATELL_PASSWORD)
      api.send_message(recipients, body)
    else
      Rails.logger.warn <<-END
Sending #{body} to #{recipients.join(',')}
END
    end
  end
end
