When "I sign in as a confirmed user" do
  create_model("a user", email: "sam@example.com", password: "password")
  sign_in_as("sam@example.com", "password")
end

When "I sign in as a confirmed user using my username" do
  create_model("a user", username: "sam", password: "password")
  sign_in_as("sam", "password")
end

When "I sign in as an unconfirmed user" do
  create_model("an unconfirmed user", email: "sam@example.com", password: "password")
  sign_in_as("sam@example.com", "password")
end

When "I sign in with the wrong password" do
  create_model("a user", email: "sam@example.com", password: "password")
  sign_in_as("sam@example.com", "wrongpassword")
end

When "I sign in with an email that isn't in the database" do
  sign_in_as("nonexistant@example.com", "password")
end

When "I sign in and my account is locked" do
  user = create_model("a user", email: "sam@example.com", password: "password")
  user.lock_with_reason!("test")
  sign_in_as("sam@example.com", "password")
end

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

Then /^I should be asked to sign in$/ do
  step "I should be on the new user session page"
end

Given /^I am signed in$/ do
  step('I am signed in as email: "bob@example.com"')
end

Given /^I am signed in as an admin$/ do
  step('I am signed in as email: "admin@example.com", admin: true')
end

Given /^I am signed in as #{capture_fields}$/ do |fields|
  fields_hash = parse_fields(fields)
  password = fields_hash['password'].present? ? fields_hash['password'] : 'password'

  if fields_hash['admin']
    user_type = "admin user"
  else
    user_type = "user"
  end

  user_info = "email: \"#{fields_hash['email']}\", password: \"#{password}\""

  step(%Q{a #{user_type} exists with #{user_info}})
  step('I go to the new user session page')
  step(%Q{I fill in "Email" with "#{fields_hash['email']}"})
  step(%Q{I fill in "Password" with "#{password}"})
  step('I press "Sign in"')
end

When /^I change my birthday to (\w+) (\d+)$/ do |month, day|
  within "#new_user" do
    select month, from: "user_birth_month"

    # For whatever reason, Capybara can't find the right option for the day without doing this.
    page.find("#user_birth_day").all("option[value='#{day}']").first.select_option
  end
end

Then /^I should be able to sign in with "([^"]*)" and "([^"]*)"$/ do |email, password|
  sign_out
  sign_in_as(email, password)
  page.should have_content("Sign out")
end

When /^I sign out$/ do
  sign_out
end

def sign_in_as(email, password)
  visit root_path
  within ".nav" do
    click_link "Sign in"
  end

  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

def sign_out
  visit "/"
  click_link "Sign out"
end
