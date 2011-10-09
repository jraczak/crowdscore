Feature: Creating a new venue

  Background:
    Given a venue category exists with name: "Restaurant"

  Scenario: A visitor cannot add a new venue
    When I go to the new venue page
    Then I should be on the new user session page

  Scenario: A user can add a new venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I press "Create"
    Then a venue should exist with name: "My Biz"
    And I should be on the venue page for the venue
    And I should see "Venue was successfully created."

  @javascript
  Scenario: A user can add a subcategory to a venue
    Given a venue subcategory exists with name: "Indian", venue_category: the venue category
    And I am signed in
    When I fill out the add a venue form for "My Biz"
    And I select "Indian" from "Subcategory"
    And I press "Create"
    Then a venue should exist with name: "My Biz", venue_subcategory: the venue subcategory

  @javascript
  Scenario: A user does not see the subcategory dropdown for categories that don't have subcategories
    Given a venue subcategory exists with name: "Indian", venue_category: the venue category
    And a venue category exists with name: "Hotel"
    And I am signed in
    When I go to the new venue page
    Then the venue subcategory dropdown should not be visible

    When I select "Restaurant" from "Category"
    Then the venue subcategory dropdown should be visible

    When I select "Hotel" from "Category"
    Then the venue subcategory dropdown should not be visible

  Scenario: A user can add a phone number to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I fill in "Phone number" with "(303) 555-2705"
    And I press "Create"
    Then a venue should exist with name: "My Biz", phone: "(303) 555-2705"

  Scenario: A user can add a second address line to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I fill in "Address 2" with "Suite 200"
    And I press "Create"
    Then a venue should exist with name: "My Biz", address2: "Suite 200"

  Scenario: A user can add a web address to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I fill in "URL" with "http://www.aol.com"
    And I press "Create"
    Then a venue should exist with name: "My Biz", url: "http://www.aol.com"

  Scenario: A user must use the right format for a web address when added to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I fill in "URL" with "www.aol.com"
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "URL must contain 'http://'"

  Scenario: A user must add a name to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I leave the "Name" field blank
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "Name can't be blank"

  Scenario: A user must add an address to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I leave the "Address 1" field blank
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "Address1 can't be blank"

  Scenario: A user must add a city to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I leave the "City" field blank
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "City can't be blank"

  Scenario: A user must add a state to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I leave the "State" field blank
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "State can't be blank"

  Scenario: A user must add a zip code to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I leave the "Zip code" field blank
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "Zip can't be blank"

  Scenario: A user must add a category to a venue
    Given I am signed in
    When I fill out the add a venue form for "My Biz"
    And I select nothing from the "Category" dropdown
    And I press "Create"
    Then a venue should not exist with name: "My Biz"
    And I should see "Venue category can't be blank"

  Scenario: A user sees the right subcategories when an error has occurred on the form
    Given a venue subcategory exists with name: "Indian", venue_category: the venue category
    And I am signed in
    When I go to the new venue page
    And I select "Restaurant" from "Category"
    And I press "Create"
    Then a venue should not exist
    And "Indian" should be an option for "Subcategory"
