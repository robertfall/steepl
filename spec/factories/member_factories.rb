FactoryGirl.define do
  factory :member do
    first_name 'Example'
    last_name 'Guy'
    gender 'Male'
    email 'test@example.com'
    date_of_birth 10.years.ago.to_date
    joined_on 1.year.ago
  end
end
