Feature: Manage users

  Background:
    Given a user: "bobby" exists with username: "bobbyb", first_name: "Bobby", last_name: "Barker", email: "bobby@example.com"
    And I am signed in as an admin

  Scenario: View a listing of users
    When I go to the admin root page
    And I follow "Users"
    Then I should see "Bobby Barker"

  Scenario: Create a new user
    When I go to the admin users page
    And I follow "Add a user"
    And I fill in "First name" with "Jason"
    And I fill in "Last name" with "Sudeikis"
    And I fill in "Email" with "jason@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "jasons"
    And I fill in "Password" with "newpass"
    And I fill in "Password confirmation" with "newpass"
    And I press "Create user"
    Then a user should exist with email: "jason@example.com"
    And the user should be confirmed
    And I should be on the admin user page for the user

  Scenario: Create a new admin
    When I go to the admin users page
    And I follow "Add a user"
    And I fill in "First name" with "Jason"
    And I fill in "Last name" with "Sudeikis"
    And I fill in "Email" with "jason@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "jasons"
    And I fill in "Password" with "newpass"
    And I fill in "Password confirmation" with "newpass"
    And I fill in "Password confirmation" with "newpass"
    And I check "Admin"
    And I press "Create user"
    Then a user should exist with email: "jason@example.com", admin: true
    And the user should be confirmed
    And I should be on the admin user page for the user

  Scenario: View a user
    When I go to the admin users page
    And I follow "bobbyb"
    Then I should be on the admin user page for user: "bobby"
    And I should see "Bobby Barker"
    And I should see "bobby@example.com"

  Scenario: Edit a user
    When I go to the admin users page
    And I follow "bobbyb"
    And I follow "Edit" within the toolbox
    And I fill in "First name" with "Mike"
    And I press "Save"
    Then I should be on the admin user page for user: "bobby"
    And a user should exist with email: "bobby@example.com", first_name: "Mike"
    And I should see "Mike Barker"

  Scenario: Change a user's password
    When I go to the admin users page
    And I follow "bobbyb"
    And I follow "Edit" within the toolbox
    And I fill in "Password" with "awesomepass"
    And I fill in "Password confirmation" with "awesomepass"
    And I press "Save"
    And I sign out

    When I go to the new user session page
    And I fill in "Email" with "bobby@example.com"
    And I fill in "Password" with "awesomepass"
    And I press "Sign in"
    Then I should be on the root page

  Scenario: Make a user an admin
    When I go to the admin users page
    And I follow "bobbyb"
    And I follow "Edit" within the toolbox
    And I check "Admin"
    And I press "Save"
    Then I should be on the admin user page for user: "bobby"
    And a user should exist with email: "bobby@example.com", admin: true

  @javascript
  Scenario: Delete a user
    When I go to the admin users page
    And I follow "bobbyb"
    And  I follow "Delete"
    And I confirm the dialog
    Then I should be on the admin users page
    Then a user should not exist with email: "bobby@example.com"

  @javascript
  Scenario: Cancelling deleting a user
    When I go to the admin users page
    And I follow "bobbyb"
    And  I follow "Delete"
    And I cancel the dialog
    Then I should be on the admin user page for user: "bobby"
    Then a user should exist with email: "bobby@example.com"

