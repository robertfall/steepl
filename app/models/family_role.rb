# == Schema Information
#
# Table name: family_roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FamilyRole < ActiveRecord::Base
  attr_accessible :name
  has_many :family_member_roles
  has_many :family_members, through: :family_member_roles
end
