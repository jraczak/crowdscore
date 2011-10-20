# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tip do
      venue
      user
      text "MyString"
    end
end
