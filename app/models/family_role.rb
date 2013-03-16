class FamilyRole < ActiveRecord::Base
  attr_accessible :name
  has_many :member_family_rol
end
