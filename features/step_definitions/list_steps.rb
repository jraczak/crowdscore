Given /^I have a list called "([^"]*)"$/ do |name|
  step %Q{a list exists with user: the user, name: "#{name}"}
end

When /^I view my lists$/ do
  step 'I follow "View My Lists"'
end

Given /^someone else has a list called "([^"]*)"$/ do |name|
  step %Q{a list exists with name: "#{name}"}
end

Then /^I should see a list called "([^"]*)"$/ do |name|
  find("table").should have_content(name)
end

Then /^I should not see a list called "([^"]*)"$/ do |name|
  find("table").should_not have_content(name)
end

Then /^I should have a list called "([^"]*)"$/ do |name|
  model!("the user").lists.pluck(:name).should include(name)
end
