class FamilyMember < ActiveRecord::Base
  attr_accessible :family_id, :member_id

  belongs_to :family
  belongs_to :member

  validates_presence_of :family, :member
  validates_associated :family
end
