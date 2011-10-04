@javascript
Feature: Deleting a venue

  Scenario: An admin can delete a venue
    Given I am signed in as an admin
    And a venue exists with name: "Denver Dogs"
    And I am on the admin venue page for the venue
    And I follow "Delete" within the toolbox
    And I confirm the dialog
    Then I should be on the admin venues page
    And I should see "Venue was successfully destroyed."
    And I should not see "Denver Dogs"

  Scenario: An admin cancels deletion a venue
    Given I am signed in as an admin
    And a venue exists with name: "Denver Dogs"
    And I am on the admin venue page for the venue
    And I follow "Delete" within the toolbox
    And I cancel the dialog
    And I go to the admin venue page for the venue
    Then I should see "Denver Dogs"
