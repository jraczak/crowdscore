Feature: Browse businesses

  Scenario: A user views a list of businesses
    Given a business exists with name: "My New Biz"
    When I go to the home page
    And I follow "Businesses"
    Then I should see "My New Biz"
