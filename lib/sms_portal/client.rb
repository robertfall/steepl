module SmsPortal
  class Client
    include HTTParty
    SMS_PORTAL_URL = "http://www.mymobileapi.com/api5/http5.aspx?"

    def initialize
      @username = "robertfall"
      @password = "ypouJ9bQUtQDZ7vPDWZWKRhp"
    end

    def send_sms(recipients, body)
      # http://www.mymobileapi.com/api5/http5.aspx?
      recipients = recipients.join(',') if recipients.is_a? Array
      params = {
        'Type' => 'sendparam',
        'username' => @username,
        'password' => @password,
        'numto' => recipients,
        'data1' => body
      }
      response = self.class.get(SMS_PORTAL_URL + params.to_query)
      binding.pry
    end

    def get_replies(max_id)
    end
  end
end

#<api_result><send_info><eventid>240620557</eventid></send_info><call_result><result>True</result><error /></call_result></api_result>
