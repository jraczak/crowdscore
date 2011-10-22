When(/^I fill out the sign up form as "(.+)"$/) do |email|
  visit new_user_registration_path
  fill_in "Email", with: email
  fill_in "First name", with: "Cucumber"
  fill_in "Username", with: "cuc-user"
  fill_in "Password", with: "password"
  fill_in "Confirm your password", with: "password"
  fill_in "And lastly, what's your zip code?", with: "90038"
end

When(/^I sign in as "(.+)" and "(.+)"$/) do |email, password|
  visit new_user_session_path
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

When(/^I change my email address to "(.+)"$/) do |email|
  fill_in "Email", with: email
  click_button "Update"
end

When(/^I change my zip code to "(.+)"$/) do |zip|
  fill_in "And lastly, what's your zip code?", with: zip
  click_button "Update"
end

When(/^I change my name to be "(.+)"$/) do |name|
  first_name, last_name = name.split(" ", 2)
  fill_in "First name", with: first_name
  fill_in "Last name", with: last_name
  click_button "Update"
end

When(/^I change my birthday to "(.+)"$/) do |date|
  month, day = date.split(" ", 2)
  select month, from: "user_birth_month"
  select day, from: "user_birth_day"
  click_button "Update"
end

When(/^I change my password to "(.+)"$/) do |password|
  fill_in "Password", with: password
  fill_in "Confirm your password", with: password
  click_button "Update"
end

Then(/^my email address should( still)? be "(.+)"$/) do |still, email|
  User.last.email.should == email
end

Then(/^my name should be "(.+)"$/) do |name|
  User.last.full_name.should == name
end

Then(/^my zip code should be "(.+)"$/) do |zip|
  User.last.zip_code.should == zip
end

Then(/^my birthday should be "(.+)"$/) do |birthday|
  month, day = birthday.split(" ", 2)
  User.last.birth_month.should == month
  User.last.birth_day.should == day.to_i
end

Then(/^my unconfirmed email address should be "(.+)"$/) do |email|
    User.last.reload.unconfirmed_email.should == email
end

Then(/^"(.+)" should receive an email containing "(.+)"$/) do |email, message|
  open_last_email
  current_email.default_part_body.to_s.should include(message)
end

Then /^I should be able to sign in with "([^"]*)" and "([^"]*)"$/ do |email, password|
  sign_out
  click_link "Sign in"
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
  page.should have_content("Sign out")
end

Then "the user is locked" do
  model!('the user').lock_with_reason!("test")
end

Then "the user should be locked" do
  User.last.access_locked?.should be_true
end

Then "the user should not be locked" do
  User.last.access_locked?.should_not be
end

Then "I should not be signed in" do
  page.should have_content("Sign in")
end

Then /^"(.+)" should link to email "(.+)"$/ do |text, email|
  page.should have_css("a[href='mailto:#{email}']", content: text)
end

When("I confirm my new email address") do
  visit_in_email("confirm")
end

When("I edit my account") do
  visit "/"
  click_link "Edit Info"
  fill_in "Current password", with: "password"
end
