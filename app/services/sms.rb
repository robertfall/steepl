class Sms
  def self.send(recipients, body)
    @instance = new
    @instance.send(recipients, body)
  end

  def send(recipients, body)
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
