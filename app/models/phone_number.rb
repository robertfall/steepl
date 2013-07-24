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

  scope :sms_capable, where("substring(dialing_code from 0 for 3) IN ('07', '08') OR name = 'Cell Number'")
  scope :newest, -> { order('created_at DESC') }

  def formatted
    "(#{dialing_code}) #{number}"
  end

  def full
    "#{dialing_code}#{number}"
  end

  def international
    "+27#{full[1..-1]}"
  end

  def sms_capable?
    (['07', '08'].include? name.slice(0,2)) or (name == 'Cell Number')
  end
end
