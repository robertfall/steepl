# == Schema Information
#
# Table name: phone_numbers
#
#  id           :integer          not null, primary key
#  member_id    :integer
#  name         :string(255)
#  dialing_code :string(255)
#  number       :string(255)
#  mobile       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PhoneNumber < ActiveRecord::Base
  attr_accessible :name, :dialing_code, :number, :mobile

  validates_presence_of :name, :dialing_code, :number

  belongs_to :member
end
