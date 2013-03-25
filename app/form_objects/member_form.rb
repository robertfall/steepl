class MemberForm
  include ActiveModel::Model

  attr_accessor :id, :first_name, :gender, :last_name, :email,
    :date_of_birth, :joined_on, :phone_numbers, :addresses,
    :family_members, :accept_communication, :cell_group,
    :preferred_service, :relationship_status, :employment_status

  validates_presence_of :first_name, :gender, :last_name
  validate :addresses_valid?
  validate :phone_numbers_valid?
  validate :family_members_valid?

  def initialize(params={})
    @accept_communication = true
    @phone_numbers = []
    @addresses = []
    @family_members = []
    super
  end

  def self.from_member(member)
    form = MemberForm.new
    form.apply_member(member)
    form
  end

  def add_default_values
    @phone_numbers << PhoneNumber.new(name: 'Home Number')
    @phone_numbers << PhoneNumber.new(name: 'Cell Number')
    @addresses << Address.new(name: 'Postal Address')
  end

  def save
    persist! if validation_status = valid?
    validation_status
  end

  def persist!
    ActiveRecord::Base.transaction do
      member = Member.where(id: @id).first || Member.new
      member.assign_attributes(scalar_values)
      member.save

      (@addresses+@phone_numbers+@family_members).each do |child|
        child.member = member
        child.save!
      end
    end
  end

  def addresses_attributes=(params)
    params.each_pair do |id, address_attributes|
      address = Address.where(id: address_attributes[:id]).first || Address.new
      address.assign_attributes(address_attributes)
      @addresses << address
    end
  end

  def phone_numbers_attributes=(params)
    params.each_pair do |id, number_attributes|
      number = PhoneNumber.where(id: number_attributes[:id]).first || PhoneNumber.new
      number.assign_attributes(number_attributes)
      @phone_numbers << number
    end
  end

  def family_members_attributes=(params)
    params.each_pair do |id, family_member_attributes|
      existing_family_member = @family_members.select do |m|
        m.id == family_member_attributes[:id].to_i
      end.first

      family_member = existing_family_member
      unless family_member
        family_member = FamilyMemberForm.new(family_member_attributes)
        @family_members << family_member
      end

      family_member.assign_attributes(family_member_attributes)
    end
  end

  def apply_member(member)
    member.attributes.each do |attr|
      send("#{attr.first}=".to_sym, attr.last) if respond_to?("#{attr.first}=".to_sym)
    end

    @phone_numbers = member.phone_numbers
    @addresses = member.addresses
    @family_members = member.family_members.map do |fm|
      FamilyMemberForm.from_family_member(fm)
    end
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
      joined_on: @joined_on,
      accept_communication: @accept_communication,
      cell_group: @cell_group,
      preferred_service: @preferred_service,
      relationship_status: @relationship_status,
      employment_status: @employment_status
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
