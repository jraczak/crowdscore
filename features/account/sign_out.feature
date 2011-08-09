Feature: Sign out

  Scenario: A user signs out
    Given I am signed in
    When I go to the home page
    And I follow "Sign out"
    Then I should see "You have been signed out."
    And I should see "Sign in"
