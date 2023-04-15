@javascript
Feature: Key management
  In order to use cryptography
  As a user
  I want to add or create PGP key pair

  Background:
    Given I am logged in
    When I am on the profile page
    Then I should see "Key Management"
    And should not see "BEGIN PGP PUBLIC KEY BLOCK"

  Scenario: user creates key pair
    When I fill in "Full name" with "Mia Doyle"
    And fill in "Passphrase" with "supersecurefakepassword"
    And press "Generate Key Pair"
    Then the "Public key" field should contain "BEGIN PGP PUBLIC KEY BLOCK"
    And the "Private key" field should contain "BEGIN PGP PRIVATE KEY BLOCK"

    When I press "Update Keys"
    Then I should see "BEGIN PGP PUBLIC KEY BLOCK" within ".info"

  @wip
  Scenario: user adds his own private key
    When I fill in "Private key" with:
      """
      -----BEGIN PGP PRIVATE KEY BLOCK-----

      xYYEY1jaRhYJKwYBBAHaRw8BAQdAi1n6rXsnXzmvv0eu6gAV4SbTtGYdi33w
      nYf0O8XIAl7+CQMIYTminmf9DPDgrbyjll8uD0mHLSVZvEj8D2kmp2n1QO8L
      NrhqaUoJGj9I/vZ19VuOTS6AsjIUBTGzbHyWiO3aWbgFosN1br4jst5pSYOP
      Sc0dTWlhIERveWxlIDxleGFtcGxlQGVtYWlsLmNvbT7CjAQQFgoAHQUCY1ja
      RgQLCQcIAxUICgQWAAIBAhkBAhsDAh4BACEJEFcj0TyI6s1EFiEEjm2N7/lm
      JUi/OBnKVyPRPIjqzUT0gwD/dogNxw6ZdruYC6p/3lZDcjH9rz96xY3YWr05
      mYk7CFwA/07KxtWQdpsSOuIUPysbLKMjMmdiieVZWcRNoSGVflQKx4sEY1ja
      RhIKKwYBBAGXVQEFAQEHQLPiqEkD8l/FWWUl6vPy6x+LGOXJEWkynh+/Phf/
      xdR6AwEIB/4JAwg5kGk3LL3HFOBYF6ItfTRNQaggv9q2a5Y+mUHqjP9Pe95m
      8oJDsJHH1NurzLpDOiAKz5A2wXp+SQUr2Yufd3PYXD1GMzlZtVD4YImhIbx7
      wngEGBYIAAkFAmNY2kYCGwwAIQkQVyPRPIjqzUQWIQSObY3v+WYlSL84GcpX
      I9E8iOrNRGODAQCAJq3gr0VYNhCopQJShkcaO9toq6Y+ydHXLgD/HbK7BAD/
      d8tWuY19B25Rof/UR/FnehyR4FBZ1nAkVJN8CB8J8QI=
      =apa4
      -----END PGP PRIVATE KEY BLOCK-----
      """
    Then the "Public key" field should contain "BEGIN PGP PUBLIC KEY BLOCK"
    And the "Fingerprint" field should contain "SLDKFK"
