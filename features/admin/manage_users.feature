Feature: Manage users

  Background:
    Given I am signed in as an admin
    And a user: "bobby" exists with username: "bobbyb", first_name: "Bobby", last_name: "Barker", email: "bobby@example.com"

  Scenario: View a listing of users
    When I go to the admin root page
    And I follow "Users"
    Then I should see "Bobby Barker"

  Scenario: Create a new user
    When I create a new user in the admin area with the email "jason@example.com"
    Then a user should exist with email: "jason@example.com"
    And the user should be confirmed
    And I should be on the admin user page for the user

  Scenario: Create a new admin
    When I create a new admin user in the admin area with the email "jason@example.com"
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
    Given I change the password of "bobbyb" to "definitely_new_pass"
    And I sign out
    When I go to the new user session page
    And I fill in "Email" with "bobby@example.com"
    And I fill in "Password" with "definitely_new_pass"
    And I press "Sign in"
    Then I should be signed in

  Scenario: Make a user an admin
    When I go to the admin users page
    And I follow "bobbyb"
    And I follow "Edit" within the toolbox
    And I check "Admin"
    And I press "Save"
    Then I should be on the admin user page for user: "bobby"
    And a user should exist with email: "bobby@example.com", admin: true

  Scenario: Lock a user
    When I go to the admin users page
    And I follow "bobbyb"
    And I follow "Lock"
    Then I should see "You are about to lock bobbyb."

    When I fill in "Reason" with "They were a big meanie"
    And I press "Lock user"
    Then I should be on the admin user page for user: "bobby"
    And the user should be locked
    And "bobby@example.com" should receive no emails
    And I should see "Locked: They were a big meanie"

  Scenario: Locking a user requires a message
    When I go to the admin users page
    And I follow "bobbyb"
    And I follow "Lock"
    And I press "Lock user"
    Then I should see "Lock reason can't be blank"
    And the user should not be locked

  @javascript
  Scenario: Unlocking a user
    Given a locked user exists with username: "locky"
    When I go to the admin user page for the locked user
    And I follow "Unlock"
    And I confirm the alert that says "You are about to unlock user: 'locky'. Are you sure you want to continue?"
    Then I should be on the admin user page for the locked user
    And I should see "This user has been unlocked."
    And I should see "Lock" within the toolbox

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

