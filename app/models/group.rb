# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name

  has_many :group_members
  has_many :members, through: :group_members

  def to_s
    "Group: #{name}"
  end
end
