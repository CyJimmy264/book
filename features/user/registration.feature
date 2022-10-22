@javascript
Feature: New user registration
  In order to use the Book
  As a desktop user
  I want to register an account

  Background:
    Given I am on the root page

  Scenario: user opens the book
    Then I should see "Log in"
    And I should see "Sign up"

  Scenario: user signs
    When I follow "Sign up"
    Then I should be on the new user registration page

    When I fill in "Email" with "example@email.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Hello example@email.com"
    And I should see "Key Management"
