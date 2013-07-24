class GroupAdapter < MessageAdapter
  def template_name
    'message_adapters/group_adapter'
  end

  def to_s
    @object.name
  end

  def email_address
    @object.members.map(&:email)
  end

  def mobile_numbers
    @object.members.map { |m| m.phone_numbers.sms_capable.first }
  end
end
