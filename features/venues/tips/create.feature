Feature: Creating tips

  Background:
    Given a venue exists

  Scenario: An anonymous user must sign in to create a tip
    When I go to the venue page for the venue
    Given I follow "Add a tip"
    Then I should be asked to sign in

  Scenario: A signed in user can add a tip
    Given I am signed in
    When I go to the venue page for the venue
    And I follow "Add a tip"
    And I fill in "Tip" with "This is only a test"
    And I press "Add my tip"
    Then I should see "Tip was successfully created."
    And I should see a tip by me that says "This is only a test"
