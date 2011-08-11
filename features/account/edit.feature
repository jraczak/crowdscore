Feature: Edit account info

  Scenario: User updates his email address
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "Email" with "newemail@example.com"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully."
    And a user should exist with email: "newemail@example.com"

  Scenario: User updates his first and last name
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I fill in "First name" with "New"
    And I fill in "Last name" with "Name"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully."
    And a user should exist with first_name: "New", last_name: "Name"

  Scenario: User updates his birthday
    Given I am signed in
    When I go to the home page
    And I follow "Edit Info"
    And I select "April" from "Birth month"
    And I select "21" from "Birth day"
    And I fill in "Current password" with "password"
    And I press "Update"
    Then I should see "You updated your account successfully."
    And the user should exist with birth_month: "April", birth_day: "21"
