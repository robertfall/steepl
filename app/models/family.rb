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
    if term.present?
      results = results.where('lower(name) LIKE ?', "%#{term.downcase}%")
    end
    results
  end

  def address
    return unless members.present? and members.first.addresses.present?
    members.first.addresses.first
  end
end
