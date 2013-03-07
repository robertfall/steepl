FactoryGirl.define do
  factory :cell_number, class: 'PhoneNumber' do
    member
    name 'Cell Number'
    dialing_code '072'
    number '1234567'
    mobile true
  end
end
