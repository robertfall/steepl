# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Role < ActiveRecord::Base
  attr_accessible :description, :name, :permissions

  has_many :role_permissions
  has_many :user_roles
  has_many :permissions, through: :role_permissions
  has_many :users, through: :user_roles
end
