Feature: Admin viewing a venue from the backend

  Scenario: An admin can see all fields that relevant to him
    Given a venue category exists with name: "Restaurant"
    And a venue subcategory exists with name: "Indian", venue_category: the venue category
    And a venue exists with name: "Ali Babas", venue_category: the venue category, venue_subcategory: the venue subcategory, address1: "123 Main St", address2: "Suite 200", city: "Denver", state: "CO", zip: "80202", url: "http://www.example.com", phone: "3035551212"
    And I am signed in as an admin
    When I go to the admin venue page for the venue
    Then I should see "Ali Babas" within the venue name
    And the venue category should be "Restaurant - Indian"
    And the venue address should be "123 Main StSuite 200Denver, CO 80202"
    And the venue phone should be "303-555-1212"
    And the venue website should be "http://www.example.com"
    And I should see "StatusActive"

