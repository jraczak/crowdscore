Feature: Home page

  Scenario: A visitor can see a home page
    When I go to the home page
    Then I should see "Welcome to CrowdScore"
