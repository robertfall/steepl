class Permission < ActiveRecord::Base
  attr_accessible :description, :name, :key

  has_many :role_permissions
  has_many :roles, through: :role_permissions
end
