class FamilyMember < ActiveRecord::Base
  attr_accessible :family_id, :member_id, :role_list

  belongs_to :family
  belongs_to :member
  has_many :family_member_roles
  has_many :family_roles, through: :family_member_roles

  validates_presence_of :family, :member
  validates_associated :family

  def role_list
    family_roles.map(&:name).join(", ")
  end

  def role_list=(names)
    self.family_roles = names.split(",").map do |n|
      FamilyRole.where(name: n.strip).first_or_create!
    end if names
  end
end
