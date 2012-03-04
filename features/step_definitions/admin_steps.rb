When(/^I create a new user in the admin area with the email "(.+)"$/) do |email|
  create_user_from_admin(email)
end

When(/^I create a new admin user in the admin area with the email "(.+)"$/) do |email|
  create_user_from_admin(email, true)
end

When /^I change the password of "(\w+)" to "(.+)"$/ do |username, password|
  user = User.find_by_username(username)
  visit admin_users_path
  click_link user.username
  within ".well" do
    click_link "Edit"
  end

  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password
  click_on "Save"
end

def create_user_from_admin(email, admin = false)
  visit admin_users_path
  click_link "Add a user"

  within "#new_user" do
    fill_in "First name", with: "Jason"
    fill_in "Last name", with: "Sudeikis"
    fill_in "Email", with: email
    fill_in "Zip code", with: "80202"
    fill_in "Username", with: "jasons"
    fill_in "user_password", with: "newpass"
    fill_in "Password confirmation", with: "newpass"
    check "Admin" if admin
    click_on "Create user"
  end
end
