Feature: Editing an existing venue

  Background:
    Given a venue category exists with name: "Restaurant"
    Given a venue exists with name: "My Venue", venue_category: the venue category
    And a venue subcategory exists with name: "New Cat", venue_category: the venue category

  Scenario: A visitor is asked to log in to edit a venue
    When I go to the venues page
    And I follow "My Venue"
    And I follow "Edit this venue's details"
    Then I should be on the new user session page

  Scenario: A user can edit a venue's details
    Given I am signed in
    When I go to the venues page
    And I follow "My Venue"
    And I follow "Edit this venue's details"
    And I fill in "Address 1" with "New Street"
    And I fill in "Address 2" with "Unit 1113"
    And I fill in "City" with "Loveland"
    And I select "Nevada" from "State"
    And I fill in "Zip code" with "88888"
    And I fill in "Phone number" with "3035551234"
    And I fill in "URL" with "http://www.differenturl.com"
    And I select "New Cat" from "Subcategory"
    And I press "Update"
    Then a venue should exist with name: "My Venue", address1: "New Street", address2: "Unit 1113", city: "Loveland", state: "NV", zip: "88888", phone: "3035551234", url: "http://www.differenturl.com"
    And the venue's full_category_name should be "Restaurant - New Cat"
    And I should be on the venue page for the venue
    And I should see "Venue was successfully updated."

  Scenario: A user cannot edit important venue fields
    Given I am signed in
    When I go to the edit venue page for the venue
    Then I should not see "Category"
    And I should not see "Name"

  @javascript
  Scenario: A user can add a website easily
    Given I am signed in
    When I go to the edit venue page for the venue
    And I follow "Add the website"
    Then I should be on the edit venue page for the venue
