# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue_score do
      venue
      user
      score1 8
      score2 2
      score3 10
      score4 0
    end
end
