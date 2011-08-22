Feature: Admin dashboard

  Scenario: An admin can see a dashboard
    Given I am signed in as an admin
    And I am on the home page
    When I follow "Administrative Area"
    Then I should be on the admin root page
    And I should see "Administrative Dashboard"

  Scenario: A visitor cannot see the admin dashboard link
    When I am on the home page
    Then I should not see "Administrative Area"

  Scenario: A visitor cannot visit the admin dashboard directly
    When I go to the admin root page
    Then I should be on the home page
    And I should see "You are not authorized to access this page."

  Scenario: A regular user cannot see the admin dashboard link
    Given I am signed in
    When I go to the home page
    Then I should not see "Administrative Area"

  Scenario: A regular user cannot visit the admin dashboard directly
    Given I am signed in
    When I go to the admin root page
    Then I should be on the home page
    And I should see "You are not authorized to access this page."
