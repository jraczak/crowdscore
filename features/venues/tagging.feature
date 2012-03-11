@javascript
Feature: Venue tagging

  Scenario: A visitor sees a message telling them to log in to add a tag
    Given a venue exists with name: "Burger Madness"
    When I go to the venue page for the venue
    And I follow "View Tags"
    Then I should see "Sign in to add a new tag." in the tag modal

  Scenario: A user sees a message saying there are no tags when there aren't any
    Given a venue exists with name: "Burger Madness"
    When I go to the venue page for the venue
    And I follow "View Tags"
    Then I should see "Tags for Burger Madness" in the tag modal
    And I should see "This venue doesn't have any tags. Why don't you go ahead and add one?" in the tag modal

  Scenario: A user can view existing tags for a venue
    Given a venue exists with name: "Burger Madness"
    And "Burger Madness" has the "has takeout" tag
    When I go to the venue page for the venue
    And I follow "View Tags"
    Then I should see the "Has..." tag heading
    Then I should see the "takeout" tag

  Scenario: A logged in user can add a new tag
    Given I am signed in as email: "bob@example.com"
    And a venue exists with name: "Burger Madness"
    And a tag category exists with name: "Serves"
    And a tag exists with name: "brunch", tag_category: the tag category
    When I go to the venue page for the venue
    And I follow "View Tags"
    And I follow "Add a new tag"
    And I select "Serves" from the tag category dropdown
    And I select "brunch" from the tag dropdown
    And I press "Add"
    Then I should see the "Serves..." tag heading
    Then I should see the "brunch" tag
