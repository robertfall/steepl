module MembersHelper
  def gender_symbol(gender)
    case gender.upcase
    when 'M', 'MALE'
      content_tag(:span, class: 'gender male') do
        '&#9794;'.html_safe
      end
    when 'F', 'FEMALE'
      content_tag(:span, class: 'gender female') do
        '&#9792;'.html_safe
      end
    end
  end

  def member_description(member)
    content_tag(:span) do
      concat "#{member.first_name} is a " unless member.family_roles.uniq.empty?
      concat "#{member.family_roles.to_sentence}. " unless member.family_roles.empty?
      if member.date_of_birth
        concat "#{member.first_name}'s birthday is on "
        concat content_tag(:strong, "#{member.birthday.strftime("%A, %B the #{member.birthday.day.ordinalize}")}. ")
        concat "#{member.gender_pronoun.titleize} is "
        concat content_tag(:strong, "#{member.age} years old. ")
      end
      concat "#{member.gender_pronoun.titleize} is " if member.relationship_status.present? or member.employment_status.present?
      should_show_relationship_status = member.age && member.age > 18 and member.relationship_status.present?
      concat "#{member.relationship_status.downcase} " if should_show_relationship_status
      concat "and " if should_show_relationship_status and member.employment_status.present?
      concat "#{member.employment_status.downcase}. " if member.employment_status.present?
    end
  end

  def address_description(address)
    content_tag :span do
      concat "#{address.member.first_name}'s "
      concat content_tag :strong, address.name
      concat " is "
      concat content_tag :strong, "#{address.description}. "
    end
  end
end
