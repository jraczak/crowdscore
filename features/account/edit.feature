Feature: Edit account info

  Scenario: User updates his email address
    Given I am signed in as email: "bob@example.com"
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "Email" with "newemail@example.com"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize your new email address."
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
    Then I should see "You updated your account successfully."
    And a user should exist with first_name: "New", last_name: "Name"

  Scenario: User updates his birthday
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I select "April" from "Birth month"
    And I select "21" from "Birth day"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully."
    And the user should exist with birth_month: "April", birth_day: "21"

  Scenario: User updates his zip code
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "Zip code" with "90048"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully."
    And a user should exist with zip_code: "90048"

  Scenario: User updates his password
    Given I am signed in as email: "bob@example.com", password: "password"
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "Password" with "mynewpass"
    And I fill in "Password confirmation" with "mynewpass"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully."

    When I sign out
    And I follow "Sign in"
    And I fill in "Email" with "bob@example.com"
    And I fill in "Password" with "mynewpass"
    And I press "Sign in"
    Then I should see "Sign out"
