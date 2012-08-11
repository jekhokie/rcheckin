@javascript
Feature: List Users with States
  In order to know who is available
  A user
  Should be able to view a list of users and their current states when logged in

  Background:
    Given I am logged in

  Scenario: User checks on co-users
    Then the Co-User tool should be visible
    And the Co-User tool should not list the user for the current session

  Scenario: A co-user is logged in
    Given a co-user "Test User" is checked in
    Then the Co-User tool should list "Test User" with an "IN" indicator star

  Scenario: A co-user is logged out
    Given a co-user "Test User" is checked out
    Then the Co-User tool should list "Test User" with an "OUT" indicator star
