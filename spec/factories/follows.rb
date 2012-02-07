# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follow do
      follower nil
      followed nil
    end
end