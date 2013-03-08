# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  gender        :string(255)
#  email         :string(255)
#  date_of_birth :date
#  joined_on     :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Member < ActiveRecord::Base
  attr_accessible :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on

  has_many :addresses
  has_many :phone_numbers

  def full_name
    [first_name, last_name].join ' '
  end

  def age
    age = Date.today.year - date_of_birth.year
    age -= 1 if Date.today < date_of_birth + age.years
    age
  end
end
