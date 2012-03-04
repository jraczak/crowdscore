Feature: Sign in

  Scenario: A confirmed user can sign in
    When I sign in as a confirmed user
    Then I should be signed in
    And I should see "Signed in successfully."

  Scenario: A user cannot sign in if their email address has not been confirmed
    When I sign in as an unconfirmed user
    Then I should not be signed in
    And I should see "You have to confirm your account before continuing."

  Scenario: A user cannot sign in if their password is incorrect
    When I sign in with the wrong password
    Then I should not be signed in
    And I should see "Invalid email or password."

  Scenario: A user cannot sign in if their account doesn't exist
    When I sign in with an email that isn't in the database
    Then I should not be signed in
    And I should see "Invalid email or password."

  Scenario: A user cannot sign in if their account is locked
    When I sign in and my account is locked
    Then I should not be signed in
    And I should see "Your account has been locked. If you believe this to be in error, please contact an administrator."
    And "contact an administrator" should link to email "help@crowdscoreapp.com"
