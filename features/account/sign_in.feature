Feature: Sign in

  Scenario: A confirmed user can sign in
    Given a user exists with email: "sam@example.com", password: "password"
    When I go to the home page
    And I follow "Sign in"
    And I fill in "Email" with "sam@example.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."

  Scenario: A user cannot sign in if their email address has not been confirmed
    Given an unconfirmed user exists with email: "sam@example.com", password: "password"
    When I go to the home page
    And I follow "Sign in"
    And I fill in "Email" with "sam@example.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "You have to confirm your account before continuing."

  Scenario: A user cannot sign in if their password is incorrect

  Scenario: A user cannot sign in if their account doesn't exist

  Scenario: A user cannot sign in if their account is locked
    Given a user exists with email: "sam@example.com", password: "password"
    And the user is locked
    When I sign in as "sam@example.com" and "password"
    Then I should not be signed in
    And I should see "Your account has been locked. If you believe this to be in error, please contact an administrator."
    And "contact an administrator" should link to email "help@crowdscoreapp.com"
