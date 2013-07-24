# == Schema Information
#
# Table name: group_members
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroupMember < ActiveRecord::Base
  attr_accessible :group_id, :member_id
  belongs_to :group
  belongs_to :member
end
