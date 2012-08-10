@javascript
Feature: Check In/Out
  In order to report their current status
  A user
  Should be able to change their state between "In" and "Out"

  Background:
    Given I am logged in

  Scenario: User checks out
    When I click "OUT" in the QuickStat tool
    Then the QuickStat tool should report me as "OUT"

  Scenario: User checks in
    When I click "IN" in the QuickStat tool
    Then the QuickStat tool should report me as "IN"
