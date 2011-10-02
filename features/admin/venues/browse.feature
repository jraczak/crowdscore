Feature: Browsing venues (admin)
  Scenario: An admin can browse a list of venues
    Given 31 venues exist
    And I am signed in as an admin
    When I go to the admin venues page
    Then there should be 30 venues displayed

    When I follow "Next"
    Then there should be 1 venue displayed

  Scenario: An admin can visit a venue's admin page
    Given a venue exists with name: "Joe's Pizza"
    And I am signed in as an admin
    When I go to the admin venues page
    And I follow "Joe's Pizza"
    Then I should be on the admin venue page for the venue
