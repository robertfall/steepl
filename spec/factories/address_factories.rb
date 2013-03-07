FactoryGirl.define do
  factory :address do
    member
    name 'Postal Address'
    address1 '1 Example Street'
    address2 'Example Suburb'
    city 'Example Town'
    postal_code '1234'
  end
end
