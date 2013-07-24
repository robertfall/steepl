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


  has_many :addresses, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members
  has_many :group_members
  has_many :groups, through: :group_members
  has_many :message_recepients
  has_many :messages, through: :message_recepients

  after_save :update_index

  def full_name
    [first_name, last_name].join ' '
  end

  def age
    return unless date_of_birth
    age = Time.zone.today.year - date_of_birth.year
    age -= 1 if Time.zone.today < date_of_birth + age.years
    age
  end

  def birthday
    return unless date_of_birth
    date_of_birth.change(year: Time.zone.today.year)
  end

  def update_index
    if self.destroyed?

    else
      MemberIndexer.new(self).store
    end
  end

  def gender_pronoun
    case gender.downcase
    when 'male', 'm'
      'he'
    when 'female', 'f'
      'she'
    end
  end

  def relatives
    families.includes(:members).map do |family|
      family.members.reject { |m| m == self }
    end.flatten
  end

  def family_roles
    family_members.map { |member| member.family_member_roles }.flatten.map { |r| r.family_role.name.downcase }.uniq
  end

  def to_s
    "Member: #{full_name}"
  end

  def mobile_number
    phone_numbers.sms_capable.first
  end
end
