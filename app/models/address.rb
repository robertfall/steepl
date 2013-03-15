# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  member_id   :integer
#  name        :string(255)
#  address1    :string(255)
#  address2    :string(255)
#  city        :string(255)
#  postal_code :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Address < ActiveRecord::Base
  attr_accessible :name, :address1, :address2, :city, :postal_code

  validates_presence_of :name, :address1, :city, :postal_code

  belongs_to :member

  def to_s
    <<-EOF
#{address1}
#{address2}
#{city}
#{postal_code}
EOF
  end
end
