Feature: Sign out
  In order to protect user accounts
  A signed in user
  Should be able to sign out

  Scenario: User signs out
    Given I am logged in
    When I sign out
    Then I should see a signed out message
    When I return to the site
    Then I should be signed out
