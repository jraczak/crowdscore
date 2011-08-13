Feature: Edit account info

  Scenario: User updates his email address
    Given I am signed in as email: "bob@example.com"
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "Email" with "newemail@example.com"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully. If you changed your email address, you'll need to confirm your new email address by clicking the link in email we've just sent."
    And a user should exist with email: "bob@example.com", unconfirmed_email: "newemail@example.com"
    And "newemail@example.com" should receive an email

    When I open the email
    Then I should see "Welcome newemail@example.com!" in the email body

    Then I follow "confirm" in the email
    Then a user should exist with email: "newemail@example.com"
    And a user should not exist with email: "sam@example.com"

  Scenario: User updates his first and last name
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "First name" with "New"
    And I fill in "Last name" with "Name"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully. If you changed your email address, you'll need to confirm your new email address by clicking the link in email we've just sent."
    And a user should exist with first_name: "New", last_name: "Name"

  Scenario: User updates his birthday
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I select "April" from "Birth month"
    And I select "21" from "Birth day"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully. If you changed your email address, you'll need to confirm your new email address by clicking the link in email we've just sent."
    And the user should exist with birth_month: "April", birth_day: "21"

  Scenario: User updates his password
    Given I am signed in as email: "bob@example.com", password: "password"
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "Password" with "mynewpass"
    And I fill in "Password confirmation" with "mynewpass"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully. If you changed your email address, you'll need to confirm your new email address by clicking the link in email we've just sent."

    When I sign out
    And I follow "Sign in"
    And I fill in "Email" with "bob@example.com"
    And I fill in "Password" with "mynewpass"
    And I press "Sign in"
    Then I should see "Sign out"
