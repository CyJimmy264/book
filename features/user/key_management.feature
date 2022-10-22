@javascript
Feature: Key management
  In order to use cryptography
  As a user
  I want to add or create PGP key pair

  Background:
    Given I am logged in
    When I am on the profile page
    Then I should see "Key Management"

  Scenario: user creates key pair
    When I fill in "Full name" with "Mia Doyle"
    And I fill in "Passphrase" with "supersecurefakepassword"
    And I press "Generate Key Pair"
    Then the "Public key" field should contain "BEGIN PGP PUBLIC KEY BLOCK"
    And the "Private key" field should contain "BEGIN PGP PRIVATE KEY BLOCK"
