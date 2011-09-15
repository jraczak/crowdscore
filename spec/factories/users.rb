FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "factory#{n}@example.com" }
    sequence(:username) { |n| "factory#{n}" }
    first_name "Factory"
    password "password"
    zip_code "80202"
    confirmed_at { 1.hour.ago }

    factory :unconfirmed_user do
      confirmed_at nil
    end

    factory :admin_user do
      admin true
    end
  end

end
