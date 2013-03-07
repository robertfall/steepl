class Member < ActiveRecord::Base
  attr_accessible :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on
end
