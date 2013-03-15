class FamilyMemberForm
  include ActiveModel::Model

  attr_accessor :family_id, :family_name, :member, :member_roles
  validate :must_have_family


  def save
    persist! if validation_status = valid?
    validation_status
  end

  def persist!
    binding.pry
    family = Family.where(id: family_id).first || Family.new
    family.assign_attributes(name: family_name)
    family.save!

    member_family = family.family_members.build(member_id: member.id)
    member_family.save
  end

  private
  def must_have_family
    unless family_id or family_name
      errors.add(:family_id, 'Family is Required')
      errors.add(:family_name, 'Family is Required')
    end
  end
end
