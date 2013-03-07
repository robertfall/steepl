class PhoneNumber
  include ActiveModel::Model
  attr_accessor :dialing_code, :number, :mobile
end
