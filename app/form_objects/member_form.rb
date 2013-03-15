class MemberForm
  include ActiveModel::Model

  attr_accessor :id, :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on, :phone_numbers, :addresses
  validates_presence_of :first_name, :gender, :last_name, :date_of_birth, :joined_on
  validate :addresses_valid?
  validate :phone_numbers_valid?
  validate :member_families_valid?

  def initialize(params={})
    @phone_numbers = []
    @addresses = []
    @member_families = []
    super
  end

  def add_default_values
    @phone_numbers << PhoneNumber.new(name: 'Home Number')
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

  def member_families_attributes=(params)
    params.each_pair do |id, member_family_attributes|
      @member_families << MemberFamilyForm.new(member_family_attributes)
    end
  end

  def save
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

  def member_families_valid?
    @member_families.each do |member_family|
      member_family.valid?
      errors["member_families.#{member_family.object_id}"].push(*member_family.errors) if member_family.errors.present?
    end
  end
end
