# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue_subcategory do
      venue_category
      name "MyString"
    end
end
