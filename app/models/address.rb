class Address
  include ActiveModel::Model
  attr_accessor :address1, :address2, :city, :postal_code

  validates_presence_of :address1, :city, :postal_code
end
