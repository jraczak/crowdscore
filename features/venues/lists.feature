@javascript
Feature: Venue lists on venue detail page

  Background:
    Given a venue exists with name: "My Venue"
    And I go to the venue page for the venue

  Scenario: An anonymous user is told they must create an account to use lists
    When I follow "Add to List"
    Then I should see "Please sign in or create an account to use lists." in the lists modal

  @logged-in
  Scenario: Open the list viewer on a venue page
    Given I have a list called "My List"
    When I follow "Add to List"
    Then I should see "My List" in the lists modal

    When I follow "All Done!"
    Then the modal should be hidden

  @logged-in
  Scenario: Add to a list
    Given I have a list called "Italian"
    When I follow "Add to List"
    And I check off the "Italian" list
    Then the venue should be in my "Italian" list

  @logged-in
  Scenario: Create a new list
    When I follow "Add to List"
    And I follow "Create new list"
    And I fill in "list_name" with "My New List"
    And I press "Create"
    Then I should see a button titled "Create new list"
    And I should have a list called "My New List"
    And the venue should be in my "My New List" list

  @logged-in
  Scenario: Remove from list
    Given the venue is in my list called "Italian"
    When I follow "Add to List"
    And I uncheck the "Italian" list
    Then the venue should not be in my "Italian" list
