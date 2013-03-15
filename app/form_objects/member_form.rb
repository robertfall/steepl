class MemberForm
  include ActiveModel::Model

  attr_accessor :id, :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on, :phone_numbers, :addresses, :family_members
  validates_presence_of :first_name, :gender, :last_name, :date_of_birth, :joined_on
  validate :addresses_valid?
  validate :phone_numbers_valid?
  validate :family_members_valid?

  def initialize(params={})
    @phone_numbers = []
    @addresses = []
    @family_members = []
    super
  end

  def add_default_values
    @phone_numbers << PhoneNumber.new(name: 'Home Number', id: 23)
    @phone_numbers << PhoneNumber.new(name: 'Cell Number')
    @addresses << Address.new(name: 'Postal Address')
  end

  def addresses_attributes=(params)
    params.each_pair do |id, address_attributes|
      address = Address.where(id: id).first || Address.new
      address.assign_attributes(address_attributes)
      @addresses << address
    end
  end

  def phone_numbers_attributes=(params)
    params.each_pair do |id, number_attributes|
      number = PhoneNumber.where(id: id).first || PhoneNumber.new
      number.assign_attributes(number_attributes)
      @phone_numbers << number
    end
  end

  def family_members_attributes=(params)
    params.each_pair do |id, family_member_attributes|
      @family_members << FamilyMemberForm.new(family_member_attributes)
    end
  end

  def save
    binding.pry
    persist! if validation_status = valid?
    validation_status
  end

  def persist!
    member = Member.where(id: @id).first || Member.new
    member.assign_attributes(scalar_values)
    @addresses.each do |address|
      address.member = member
    end

    @phone_numbers.each do |phone_number|
      phone_number.member = member
    end
    member.save

    binding.pry
    @family_members.each do |family_member|
      family_member.member = member
      family_member.persist!
    end
    (@addresses + @phone_numbers).map &:save
  end

  private
  def scalar_values
    {
      id: @id,
      first_name: @first_name,
      gender: @gender,
      last_name: @last_name,
      email: @email,
      date_of_birth: @date_of_birth,
      joined_on: @joined_on
    }
  end
  def addresses_valid?
    @addresses.each do |address|
      address.valid?
      errors["addresses.#{address.object_id}"].push(*address.errors) if address.errors.present?
    end
  end

  def phone_numbers_valid?
    @phone_numbers.each do |phone_number|
      phone_number.valid?
      errors["phone_numbers.#{phone_number.object_id}"].push(*phone_number.errors) if phone_number.errors.present?
    end
  end

  def family_members_valid?
    @family_members.each do |family_member|
      family_member.valid?
      errors["family_members.#{family_member.object_id}"].push(*family_member.errors) if family_member.errors.present?
    end
  end
end
