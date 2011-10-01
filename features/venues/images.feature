Feature: Attaching images to venues
  Background:
    Given a venue exists with name: "Bouchon"

  Scenario: A user can browse images that are attached
    Given a venue exists
    And a venue image exists with venue: the venue, caption: "My awesome dinner"
    When I go to the venue page for the venue
    Then I should see a venue image

  Scenario: A user must log in to attach an image
    When I go to the venue page for the venue
    And I follow "Add a new image"
    Then I should be on the new user session page

  Scenario: A logged in user can attach a new image
    Given I am signed in
    When I go to the venue page for the venue
    Then I should not see a venue image

    When I follow "Add a new image"
    And I fill in "Caption" with "My pic"
    And I attach the file "spec/test_files/venue_image.jpg" to "Image file"
    And I press "Upload"
    Then I should be on the venue page for the venue
    And I should see a venue image

  Scenario: An image must include the image file
    Given I am signed in
    When I go to the venue page for the venue
    And I follow "Add a new image"
    And I press "Upload"
    Then I should see "Image file can't be blank"
