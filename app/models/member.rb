# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  gender        :string(255)
#  email         :string(255)
#  date_of_birth :date
#  joined_on     :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Member < ActiveRecord::Base
  attr_accessible :first_name, :gender, :last_name, :email, :date_of_birth, :joined_on
end
