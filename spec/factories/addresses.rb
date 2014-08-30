# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    full_address "MyText"
    postcode "MyText"
  end
end
