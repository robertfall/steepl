class FamilyRole < ActiveRecord::Base
  attr_accessible :name
  has_many :family_member_roles
  has_many :family_members, through: :family_member_roles
end
