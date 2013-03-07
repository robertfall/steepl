class MemberForm
  include ActiveModel::Model

  attr_accessor :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on, :phone_numbers, :addresses
  validates_presence_of :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on

  def initialize(params)
    @phone_numbers = []
    @addresses = []
    super
  end

  def addresses=(params)
    params.each do |address|
      @addresses << Address.new(address)
    end
  end

  def phone_numbers=(params)
    params.each do |number|
      @phone_numbers << PhoneNumber.new(number)
    end
  end
end
