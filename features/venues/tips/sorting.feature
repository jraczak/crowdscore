Feature: Sorting tips
  Background:
    Given a venue exists
    And a tip was created yesterday for the venue with text: "First tip"
    And a tip was created just now for the venue with text: "New tip"

  Scenario: Tips are sorted in reverse chronological order by default
    When I go to the venue page for the venue
    Then I should see "New tip" before "First tip"

  @javascript
  Scenario: Tips can be re-sorted by popularity
    Given "First tip" has been upvoted
    When I go to the venue page for the venue
    And I follow "Popularity"
    Then I should see "First tip" before "New tip"

  @javascript
  Scenario: Tips can be re-re-sorted back into reverse chron order
    Given "First tip" has been upvoted
    When I go to the venue page for the venue
    And I follow "Popularity"
    And I follow "Recent"
    Then I should see "New tip" before "First tip"
