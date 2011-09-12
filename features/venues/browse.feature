Feature: Browse venues

  Scenario: A user views a list of venues
    Given a venue exists with name: "My New Biz"
    When I go to the home page
    And I follow "Venues"
    Then I should see "My New Biz"
