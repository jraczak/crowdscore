Feature: Import venues from other sources

  Scenario: An admin can import a venue from a XLS file
    Given I am signed in as an admin
    And a venue category exists with name: "Restaurant"
    When I go to the admin root page
    And I follow "Venues"
    And I follow "Import CSV file"
    And I attach the file "spec/test_files/valid_venues.csv" to "CSV file"
    And I press "Import"
    Then I should see "3 venue(s) were successfully imported."

  Scenario: An admin can import some venues successfully and is told others didn't work
    Given I am signed in as an admin
    And a venue category exists with name: "Restaurant"
    When I go to the admin root page
    And I follow "Venues"
    And I follow "Import CSV file"
    And I attach the file "spec/test_files/mostly_valid_venues.csv" to "CSV file"
    And I press "Import"
    Then I should see "2 venue(s) were successfully imported. 1 venue(s) could not be imported."

  Scenario: An admin is told the file couldn't be parsed
    Given I am signed in as an admin
    When I go to the admin root page
    And I follow "Venues"
    And I follow "Import CSV file"
    And I attach the file "spec/test_files/venues_with_encoding_issue.csv" to "CSV file"
    And I press "Import"
    Then I should see "Csv file is not valid"

  Scenario: An admin gets an error if they don't upload a file
    Given I am signed in as an admin
    When I go to the admin root page
    And I follow "Venues"
    And I follow "Import CSV file"
    And I press "Import"
    Then I should see "Csv file can't be blank"
