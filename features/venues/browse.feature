Feature: Browse venues

  Scenario: A user views a list of venues
    Given a venue exists with name: "My New Biz"
    When I go to the home page
    And I follow "Venues"
    Then I should see "My New Biz"

  Scenario: A user can browse pages of venues
    Given 31 venues exist
    When I go to the venues page
    Then there should be 30 venues displayed

    When I follow "Next"
    Then there should be 1 venue displayed

  Scenario: A user does not see inactive venues in the venue listing
    Given a venue exists with name: "Totally Open!"
    Given an inactive venue exists with name: "Totally Closed!"
    When I go to the venues page
    Then I should see "Totally Open!"
    Then I should not see "Totally Closed!"

  @allow-rescue
  Scenario: A user cannot go to an inactive venue's page
    Given an inactive venue exists with name: "Totally Closed!"
    When I go to the venue page for the inactive venue
    Then I should see "ActiveRecord::RecordNotFound"
