# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Permission < ActiveRecord::Base
  attr_accessible :description, :name, :key

  has_many :role_permissions
  has_many :roles, through: :role_permissions
end
