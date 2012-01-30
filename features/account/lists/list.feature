Feature: A user can see a list of their Lists

  Scenario: An anonymous user can't see lists
    When I go to the home page
    Then I should not see "View My Lists"

    When I go to the lists page
    Then I should be asked to sign in

  @logged-in
  Scenario: A user can see his lists
    Given I have a list called "Best Denver Italian"
    When I view my lists
    Then I should see a list called "Best Denver Italian"

  @logged-in
  Scenario: A user cannot see anyone else's lists on their dashboard
    Given I have a list called "Best in Denver"
    And someone else has a list called "Worst Restaurants"
    When I view my lists
    Then I should not see a list called "Worst Restaurants"

  @logged-in
  Scenario: A user with no lists is told to create one
    When I view my lists
    Then I should see "You don't have any lists yet."
