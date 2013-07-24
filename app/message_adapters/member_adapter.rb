class MemberAdapter < MessageAdapter
  def template_name
    'message_adapters/member_adapter'
  end

  def to_s
    @object.full_name
  end

  def email_address
    @object.email
  end

  def mobile_numbers
    phone_numbers.sms_capable.first
  end
end
