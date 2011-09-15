Feature: User registration

  Scenario: A user can sign up
    When I go to the home page
    And I follow "Sign up"
    And I fill in "Email" with "sam@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "First name" with "Sam"
    And I fill in "Username" with "sam"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "You have signed up successfully. Please check your email to activate your account, then we can log you in."
    And a user should exist with email: "sam@example.com", first_name: "Sam"
    And the user should not be confirmed

  Scenario: A user must enter an email address
    When I go to the new user registration page
    And I fill in "Username" with "sam"
    And I fill in "Zip code" with "80202"
    And I fill in "First name" with "Sam"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "Email can't be blank"
    And a user should not exist

  Scenario: A user must enter a unique email address
    Given a user exists with email: "sam@example.com"
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Username" with "sam"
    And I fill in "Zip code" with "80202"
    And I fill in "First name" with "Sam"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "Email has already been taken"
    And a user should not exist with username: "sam"

  Scenario: A user must enter a zip code
    When I go to the new user registration page
    And I fill in "Username" with "sam"
    And I fill in "First name" with "Sam"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "Email can't be blank"
    And a user should not exist

  Scenario: A user must enter a first name
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "sam"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "First name can't be blank"
    And a user should not exist

  Scenario: A user must enter a username
    When I go to the new user registration page
    And I fill in "First name" with "Sam"
    And I fill in "Zip code" with "80202"
    And I fill in "Email" with "sam@example.com"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "Username can't be blank"
    And a user should not exist

  Scenario: A user must choose a unique username
    Given a user exists with username: "sammydavis"
    When I go to the new user registration page
    And I fill in "First name" with "Sam"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "sammydavis"
    And I fill in "Email" with "sam@example.com"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then I should see "Username has already been taken"
    And a user should not exist with email: "sam@example.com"

  Scenario: A user must enter a valid password
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "sam"
    And I fill in "First name" with "Sam"
    And I fill in "Password" with "test1"
    And I fill in "Password confirmation" with "test1"
    And I press "Sign up"
    Then I should see "Password is too short (minimum is 6 characters)"
    And a user should not exist

  Scenario: A user must confirm their password
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "sam"
    And I fill in "First name" with "Sam"
    And I fill in "Password" with "test12"
    And I fill in "Password" with "test13"
    And I press "Sign up"
    Then I should see "Password doesn't match confirmation"
    And a user should not exist

  Scenario: A user confirms their password
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "sam"
    And I fill in "First name" with "Sam"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then "sam@example.com" should receive an email

    When I open the email
    Then I should see "Confirmation instructions" in the email subject

    When I follow "confirm" in the email
    Then a user should exist with email: "sam@example.com"
    And the user should be confirmed
    And I should see "Your account was successfully confirmed. You are now signed in."

  Scenario: A user can enter their last name
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Zip code" with "80202"
    And I fill in "Username" with "sam"
    And I fill in "First name" with "Sam"
    And I fill in "Last name" with "Smith"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
 
  Scenario: A user can enter their birthday
    When I go to the new user registration page
    And I fill in "Email" with "sam@example.com"
    And I fill in "Username" with "sam"
    And I fill in "Zip code" with "80202"
    And I fill in "First name" with "Sam"
    And I select "July" from "Birth month"
    And I select "5" from "Birth day"
    And I fill in "Password" with "mynewpassword"
    And I fill in "Password confirmation" with "mynewpassword"
    And I press "Sign up"
    Then a user should exist with email: "sam@example.com", birth_month: "July", birth_day: "5"
