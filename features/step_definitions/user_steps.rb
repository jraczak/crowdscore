Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.diff!(tableish('table tr', 'td,th'))
end

Given /^I am signed in$/ do
  Given('a user exists with email: "bob@example.com", password: "password"')
  When('I go to the new user session page')
  And('I fill in "Email" with "bob@example.com"')
  And('I fill in "Password" with "password"')
  And('I press "Sign in"')
end
