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
  Given('I am signed in as email: "bob@example.com"')
end

Given /^I am signed in as an admin$/ do
  Given('I am signed in as email: "admin@example.com", admin: true')
end

Given /^I am signed in as #{capture_fields}$/ do |fields|
  fields_hash = parse_fields(fields)
  password = fields_hash['password'].present? ? fields_hash['password'] : 'password'

  user_info = "email: \"#{fields_hash['email']}\", password: \"#{password}\""
  user_info += ", admin: #{fields_hash['admin']}" if fields_hash['admin'].present?

  Given(%Q{a user exists with #{user_info}})
  When('I go to the new user session page')
  And(%Q{I fill in "Email" with "#{fields_hash['email']}"})
  And(%Q{I fill in "Password" with "#{password}"})
  And('I press "Sign in"')
end

When /^I sign out$/ do
  When('I go to the home page')
  And('I follow "Sign out"')
end
