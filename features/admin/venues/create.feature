Feature: Creating a new venue as an admin

  Background:
    Given a venue category exists with name: "Restaurant"

  Scenario: A visitor cannot add a new venue via the admin area
    When I go to the new admin venue page
    Then I should be on the home page

  Scenario: A regular user cannot add a new venue via the admin area
    Given I am signed in
    When I go to the new admin venue page
    Then I should be on the home page

  Scenario: A user can add a new venue
    Given I am signed in as an admin
    When I go to the admin venues page
    And I follow "Add a venue"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "City" with "Denver"
    And I select "Colorado" from "State"
    And I fill in "Zip code" with "80202"
    And I select "Restaurant" from "Category"
    And I uncheck "Active"
    And I press "Create"
    Then a venue should exist with name: "My Biz"
    And that venue should not be active
    And I should be on the admin venue page for the venue
    And I should see "Venue was successfully created."

