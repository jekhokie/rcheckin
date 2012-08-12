@javascript
Feature: List Users with States
  In order to know who is available
  A user
  Should be able to view a list of users and their current states when logged in

  Background:
    Given I exist as a user
    And I am not logged in

  Scenario: User checks on co-users
    When I sign in with valid credentials
    Then the Co-Users tool should be visible
    And the Co-Users tool should not list the user for the current session

  Scenario: A co-user is logged in
    Given a co-user with the name "Random User" is currently IN
    When I sign in with valid credentials
    Then the Co-Users tool should list "Random User" with an IN indicator star

  Scenario: A co-user is logged out
    Given a co-user with the name "Random User" is currently OUT
    When I sign in with valid credentials
    Then the Co-Users tool should list "Random User" with an OUT indicator star
