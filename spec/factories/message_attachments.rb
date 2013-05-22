# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_attachment do
    attachable_id 1
    attachable_type "MyString"
    message_id 1
  end
end
