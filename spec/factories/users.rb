FactoryGirl.define do
  factory :user do
    email "sam@example.com"
    first_name "Sam"
    password "password"
    confirmed_at { 1.hour.ago }

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end

end
