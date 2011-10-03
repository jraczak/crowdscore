Feature: Venue activation
  Background:
    Given I am signed in as an admin

  Scenario: A venue can be deactivated
    Given a venue exists with active: true
    When I go to the edit admin venue page for the venue
    And I uncheck "Active"
    And I press "Update"
    Then I should be on the admin venue page for the venue
    And I should see "StatusInactive"
    And that venue should not be active

  Scenario: A newly created venue is activated by default
    Given a venue exists
    When I go to the admin venue page for the venue
    Then I should see "StatusActive"
