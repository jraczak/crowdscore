Feature: User registration

  Scenario: A user can get to the sign up page from the home page
    When I go to the home page
    And I follow "Let's Get Started"
    Then I should be on the new user registration page

  Scenario: A user can get to the sign up page from the nav bar
    When I go to the home page
    And I follow "Sign up" within the nav bar
    Then I should be on the new user registration page

  Scenario: A user can sign up by filling in the required fields
    When I fill out the sign up form as "sam@example.com"
    And I press "Sign me up!"
    Then I should see "You have signed up successfully. Please check your email to activate your account, then we can log you in."
    And a user should exist with email: "sam@example.com"
    And the user should not be confirmed

  Scenario: A user must enter an email address
    When I fill out the sign up form as "sam@example.com"
    And I leave the "Email" field blank
    And I press "Sign me up!"
    Then I should see "Email can't be blank"
    And a user should not exist

  Scenario: A user must enter a unique email address
    Given a user exists with email: "sam@example.com"
    When I fill out the sign up form as "sam@example.com"
    And I press "Sign me up!"
    Then I should see "Email has already been taken"

  Scenario: A user must enter a zip code
    When I fill out the sign up form as "sam@example.com"
    And I leave the "And lastly, what's your zip code?" field blank
    And I press "Sign me up!"
    Then I should see "Zip code can't be blank"
    And a user should not exist

  Scenario: A user must enter a first name
    When I fill out the sign up form as "sam@example.com"
    And I leave the "First name" field blank
    And I press "Sign me up!"
    Then I should see "First name can't be blank"
    And a user should not exist

  Scenario: A user must enter a username
    When I fill out the sign up form as "sam@example.com"
    And I leave the "Username" field blank
    And I press "Sign me up!"
    Then I should see "Username can't be blank"
    And a user should not exist

  Scenario: A user must choose a unique username
    Given a user exists with username: "sammydavis"
    When I fill out the sign up form as "sam@example.com"
    And I fill in "Username" with "sammydavis"
    And I press "Sign me up!"
    Then I should see "Username has already been taken"
    And a user should not exist with email: "sam@example.com"

  Scenario: A user must enter a valid password
    When I fill out the sign up form as "sam@example.com"
    And I fill in "Password" with "test1"
    And I fill in "Confirm your password" with "test1"
    And I press "Sign me up!"
    Then I should see "Password is too short (minimum is 6 characters)"
    And a user should not exist

  Scenario: A user must confirm their password
    When I fill out the sign up form as "sam@example.com"
    And I leave the "Confirm your password" field blank
    And I press "Sign me up!"
    Then I should see "Password doesn't match confirmation"
    And a user should not exist

  Scenario: A user confirms their password
    When I fill out the sign up form as "sam@example.com"
    And I press "Sign me up!"
    Then "sam@example.com" should receive an email

    When I open the email
    Then I should see "Confirmation instructions" in the email subject
    And they should see the email delivered from "support@crowdscoreapp.com"

    When I follow "confirm" in the email
    Then a user should exist with email: "sam@example.com"
    And the user should be confirmed
    And I should see "Your account was successfully confirmed. You are now signed in."

  Scenario: A user can enter their last name
    When I fill out the sign up form as "sam@example.com"
    And I fill in "Last name" with "Smith"
    And I press "Sign me up!"
    Then a user should exist with last_name: "Smith"

  Scenario: A user can enter their birthday
    When I fill out the sign up form as "sam@example.com"
    And I change my birthday to July 5
    And I press "Sign me up!"
    Then a user should exist with email: "sam@example.com", birth_month: "July", birth_day: "5"
