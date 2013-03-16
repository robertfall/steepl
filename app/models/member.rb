# == Schema Information
#
# Table name: members
#
#  id                   :integer          not null, primary key
#  first_name           :string(255)
#  last_name            :string(255)
#  gender               :string(255)
#  email                :string(255)
#  date_of_birth        :date
#  joined_on            :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  relationship_status  :string(255)
#  employment_status    :string(255)
#  accept_communication :boolean
#  cell_group           :string(255)
#  preferred_service    :string(255)
#

class Member < ActiveRecord::Base
  attr_accessible :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on, :relation,
    :accept_communication, :cell_group, :preferred_service, :relationship_status, :employment_status


  has_many :addresses
  has_many :phone_numbers
  has_many :family_members
  has_many :families, through: :family_members

  def full_name
    [first_name, last_name].join ' '
  end

  def age
    age = Date.today.year - date_of_birth.year
    age -= 1 if Date.today < date_of_birth + age.years
    age
  end
end
