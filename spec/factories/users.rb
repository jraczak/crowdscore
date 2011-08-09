FactoryGirl.define do
  factory :user do
    email "sam@example.com"
    first_name "Sam"
    password "password"
    confirmed_at { 1.hour.ago }
  end

  factory :unconfirmed_user, parent: :user do
    confirmed_at nil
  end
end
