Feature: Creating a new business

  Scenario: A visitor cannot add a new business
    When I go to the new business page
    Then I should be on the new user session page

  Scenario: A user can add a new business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "City" with "Denver"
    And I fill in "State" with "CO"
    And I fill in "Zip code" with "80202"
    And I press "Create"
    Then a business should exist with name: "My Biz"
    And I should be on the business page for the business
    And I should see "Business was successfully created."

  Scenario: A user can add a phone number to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "City" with "Denver"
    And I fill in "State" with "CO"
    And I fill in "Zip code" with "80202"
    And I fill in "Phone number" with "(303) 555-2705"
    And I press "Create"
    Then a business should exist with name: "My Biz"
    And I should be on the business page for the business
    And I should see "Business was successfully created."

  Scenario: A user can add a second address line to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "Address 2" with "Suite 200"
    And I fill in "City" with "Denver"
    And I fill in "State" with "CO"
    And I fill in "Zip code" with "80202"
    And I press "Create"
    Then a business should exist with name: "My Biz"
    And I should be on the business page for the business
    And I should see "Business was successfully created."

  Scenario: A user must add a name to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "City" with "Denver"
    And I fill in "State" with "CO"
    And I fill in "Zip code" with "80202"
    And I press "Create"
    Then a business should not exist with name: "My Biz"
    And I should see "Name can't be blank"

  Scenario: A user must add an address to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "City" with "Denver"
    And I fill in "State" with "CO"
    And I fill in "Zip code" with "80202"
    And I press "Create"
    Then a business should not exist with name: "My Biz"
    And I should see "Address1 can't be blank"

  Scenario: A user must add a city to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "State" with "CO"
    And I fill in "Zip code" with "80202"
    And I press "Create"
    Then a business should not exist with name: "My Biz"
    And I should see "City can't be blank"

  Scenario: A user must add a state to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "City" with "Denver"
    And I fill in "Zip code" with "80202"
    And I press "Create"
    Then a business should not exist with name: "My Biz"
    And I should see "State can't be blank"

  Scenario: A user must add a zip code to a business
    Given I am signed in
    When I go to the businesses page
    And I follow "Add a business"
    And I fill in "Name" with "My Biz"
    And I fill in "Address 1" with "123 Main St"
    And I fill in "City" with "Denver"
    And I fill in "State" with "CO"
    And I press "Create"
    Then a business should not exist with name: "My Biz"
    And I should see "Zip can't be blank"
