When(/^I wait (\d+) seconds?$/) do |num|
  sleep num.to_i
end

When "I pry" do
  binding.pry
end
