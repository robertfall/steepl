class MemberForm
  include ActiveModel::Model

  attr_accessor :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on
  validates_presence_of :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on

  def addresses=(params)
  end

  def phone_numbers=(params)
  end
end
