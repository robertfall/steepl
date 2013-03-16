# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Family < ActiveRecord::Base
  attr_accessible :name

  has_many :family_members
  has_many :members, through: :family_members

  def self.search(term)
    results = scoped
    if term
      results = results.where('lower(name) LIKE ?', "%#{term}%")
    end
    results
  end
end
