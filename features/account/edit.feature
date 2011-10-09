Feature: Edit account info

  Scenario: User updates his email address
    Given I am signed in as email: "bob@example.com"
    When I edit my account
    And I change my email address to "newemail@example.com"
    Then my email address should still be "bob@example.com"
    And my unconfirmed email address should be "newemail@example.com"
    And I should see "You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize your new email address."
    And "newemail@example.com" should receive an email containing "Welcome newemail@example.com!"

    When I confirm my new email address
    Then my email address should be "newemail@example.com"
    And a user should not exist with email: "bob@example.com"

  Scenario: User updates his first and last name
    Given I am signed in
    When I edit my account
    And I change my name to be "New Name"
    Then I should see "You updated your account successfully."
    And my name should be "New Name"

  Scenario: User updates his birthday
    Given I am signed in
    When I edit my account
    And I change my birthday to "April 21"
    Then I should see "You updated your account successfully."
    And my birthday should be "April 21"

  Scenario: User updates his zip code
    Given I am signed in
    When I edit my account
    And I change my zip code to "90048"
    Then I should see "You updated your account successfully."
    And my zip code should be "90048"

  Scenario: User updates his password
    Given I am signed in as email: "bob@example.com", password: "password"
    When I edit my account
    And I change my password to "mynewpass"
    Then I should see "You updated your account successfully."
    And I should be able to sign in with "bob@example.com" and "mynewpass"
