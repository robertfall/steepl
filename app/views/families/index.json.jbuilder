json.array!(@families) do |family|
  json.id family.id
  json.name family.name
  json.members family.members do |member|
    json.firstName member.first_name
    json.lastName member.last_name
    json.addresses member.addresses do |address|
      json.address1 address.address1
      json.address2 address.address2
      json.city address.city
      json.postalCode address.postal_code
    end
  end
end
