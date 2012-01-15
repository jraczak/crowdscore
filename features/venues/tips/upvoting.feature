Feature: Upvoting tips

  Background:
    Given a venue exists

  Scenario: An anonymous user cannot upvote
    Given a tip was created yesterday for the venue with text: "First tip"
    When I go to the venue page for the venue
    Then I should not see "upvote"

  Scenario: A signed in user can upvote someone else's tip
    Given a tip was created yesterday for the venue with text: "First tip"
    And I am signed in
    When I go to the venue page for the venue
    Then I should see "upvote"

    When I follow "upvote"
    Then my upvote for the tip should have been recorded
    And I should be on the venue page for the venue
    And I should not see "upvote" within "#tips"

  Scenario: A signed in user cannot upvote their own tip
    Given I am signed in
    And I created a tip for the venue with text: "My tip"
    When I go to the venue page for the venue
    Then I should not see "upvote" within "#tips"

  Scenario: Number of upvotes should be displayed next to a tip
    Given a tip was created yesterday for the venue with text: "First tip"
    And "First tip" has been upvoted
    When I go to the venue page for the venue
    Then I should see "(1 vote)" next to the "First tip" tip

