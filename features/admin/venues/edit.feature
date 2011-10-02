Feature: Admin editing of venues

  Scenario: An admin can edit a venue
    Given I am signed in as an admin
    And a venue exists with name: "Mike's BBQ"
    When I go to the admin root page
    And I follow "Venues"
    And I follow "Mike's BBQ"
    And I follow "Edit" within the toolbox
    And I fill in "Name" with "Bill's BBQ"
    And I press "Update"
    Then I should be on the admin venue page for the venue
    And I should see "Bill's BBQ"
    And I should not see "Mike's BBQ"

  Scenario: A regular user cannot edit
    Given I am signed in
    And a venue exists with name: "Mike's BBQ"
    When I go to the edit admin venue page for the venue
    Then I should be on the home page
