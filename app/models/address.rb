class Address
  include ActiveModel::Model
  attr_accessor :name, :address1, :address2, :city, :postal_code

  validates_presence_of :name, :address1, :city, :postal_code
end
