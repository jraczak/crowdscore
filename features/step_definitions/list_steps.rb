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

When /^I check off the "([^"]*)" list$/ do |name|
  check(name)
end

When /^I uncheck the "([^"]*)" list$/ do |name|
  uncheck(name)
end

Then /^the venue should be in my "([^"]*)" list$/ do |name|
  list = model!("the user").lists.find_by_name(name)
  list.venues.should include(model!("the venue"))
end

Then /^the venue should not be in my "([^"]*)" list$/ do |name|
  list = model!("the user").lists.find_by_name(name)
  list.venues.should_not include(model!("the venue"))
end

Given /^the venue is in my list called "([^"]*)"$/ do |name|
  list = model!("the user").lists.find_or_create_by_name(name)
  list.venues << model!('the venue')
end
