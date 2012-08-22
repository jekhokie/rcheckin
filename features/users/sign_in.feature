Feature: Sign in
  In order to get access to a specific account
  A user
  Should be able to sign in

  Scenario: User is not signed up
    Given I do not exist as a user
    When I sign in via Facebook with valid credentials
    Then I should see the create new account page
    When I submit the new account information
    Then I should see a successful account creation message
    And I should be signed in

  Scenario: User signs in successfully
    Given I exist as a user
    And I am not logged in
    When I sign in via Facebook with valid credentials
    Then I see a successful sign in message
    When I return to the site
    Then I should be signed in
