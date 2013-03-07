class PhoneNumber < ActiveRecord::Base
  attr_accessible :name, :dialing_code, :number, :mobile

  validates_presence_of :name, :dialing_code, :number

  belongs_to :member
end
