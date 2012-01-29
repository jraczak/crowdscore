@javascript
Feature: Venue lists on venue detail page

  Background:
    Given a venue exists
    And I go to the venue page for the venue

  Scenario: An anonymous user is told they must create an account to use lists
    When I follow "Add to List"
    Then I should see "Please sign in or create an account to use lists." in the modal

  @wip @logged-in
  Scenario: Open the list viewer on a venue page
    Then I should see "test"

