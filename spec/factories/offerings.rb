# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :offering do
    member nil
    amount_cents 1
    given_on "2014-02-19"
    method "MyString"
  end
end
