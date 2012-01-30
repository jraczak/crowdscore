Feature: A user can create a new list

  Scenario: An visitor can't create a new list
    When I go to the new list page
    Then I should be asked to sign in

  @logged-in
  Scenario: A user can create a new list
    When I go to the new list page
    And I fill in "Name" with "My List"
    And I press "Create"
    Then I should have a list called "My List"
