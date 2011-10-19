FactoryGirl.define do
  factory :venue do
    name "Brian's Great Bar"
    address1 "123 Test St"
    city "Denver"
    state "Colorado"
    zip "80202"
    venue_category
  end

  factory :inactive_venue, parent: :venue do
    active false
  end
end
