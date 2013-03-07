class MemberForm
  include ActiveModel::Model

  attr_accessor :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on, :phone_numbers, :addresses
  validates_presence_of :first_name, :gender, :last_name, :date_of_birth, :joined_on
  validate :addresses_valid?
  validate :phone_numbers_valid?

  def initialize(params)
    @phone_numbers = []
    @addresses = []
    super
  end

  def add_default_values
    @phone_numbers << PhoneNumber.new(name: 'Home Number')
    @phone_numbers << PhoneNumber.new(name: 'Cell Number')
    @addresses << Address.new(name: 'Postal Address')
  end

  def addresses_attributes=(params)
    params.values.each do |address|
      @addresses << Address.new(address)
    end
  end

  def phone_numbers_attributes=(params)
    params.values.each do |number|
      @phone_numbers << PhoneNumber.new(number)
    end
  end

  private
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
end
