class FamilyMemberRole < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :family_role
  belongs_to :family_member
end
