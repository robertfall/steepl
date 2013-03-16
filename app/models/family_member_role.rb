# == Schema Information
#
# Table name: family_member_roles
#
#  id               :integer          not null, primary key
#  family_role_id   :integer
#  family_member_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class FamilyMemberRole < ActiveRecord::Base
  attr_accessible :title, :body

  belongs_to :family_role
  belongs_to :family_member
end
