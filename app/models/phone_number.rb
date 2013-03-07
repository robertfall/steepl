class PhoneNumber
  include ActiveModel::Model
  attr_accessor :name, :dialing_code, :number, :mobile

  validates_presence_of :name, :dialing_code, :number, :mobile
end
