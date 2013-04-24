json.array!(@filter_form.results) do |member|
 json.id member.id
 json.fullName member.full_name
 json.email member.email
 json.age member.age
 json.dateOfBirth member.date_of_birth
 json.birthday member.birthday
 json.phoneNumbers member.phone_numbers member.phone_numbers
 json.addresses  member.addresses
 json.preferredService member.preferred_service
 json.gender member.gender
 json.relationshipStatus member.relationship_status
 json.employmentStatus member.employment_status
 json.showPath member_path(member)
 json.editPath edit_member_path(member)
end
