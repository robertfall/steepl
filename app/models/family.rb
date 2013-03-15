class Family < ActiveRecord::Base
  attr_accessible :name

  has_many :family_members
end
