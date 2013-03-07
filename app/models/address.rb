class Address < ActiveRecord::Base
  attr_accessible :name, :address1, :address2, :city, :postal_code

  validates_presence_of :name, :address1, :city, :postal_code

  belongs_to :member
end
