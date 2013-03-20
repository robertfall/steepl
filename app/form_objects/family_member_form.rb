class FamilyMemberForm
  include ActiveModel::Model

  attr_accessor :id, :family_id, :family_name, :member, :role_list
  validate :must_have_family


  def save
    persist! if validation_status = valid?
    validation_status
  end

  def self.from_family_member(family_member)
    return nil unless family_member
    form = FamilyMemberForm.new(id: family_member.id,
                                family_id: family_member.family.id,
                                family_name: family_member.family.name,
                                member: family_member.member,
                                role_list: family_member.role_list)
    form
  end

  def persist!
    family = Family.where(id: family_id).first || Family.new
    family.assign_attributes(name: family_name) if family_name
    family.save!

    family_member = family.family_members.where(id: id).first || family.family_members.build
    family_member.assign_attributes(member_id: member.id, role_list: role_list)
    family_member.save
  end

  private
  def must_have_family
    unless family_id or family_name
      errors.add(:family_id, 'Family is Required')
      errors.add(:family_name, 'Family is Required')
    end
  end
end
