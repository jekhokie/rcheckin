@javascript
Feature: Check In/Out
  In order to report their current status
  A user
  Should be able to change their state between "In" and "Out" only when they are logged in

  Scenario: User checks out
    Given I am logged in
    When I click "OUT" in the QuickStat tool
    Then the QuickStat tool should report me as "OUT"

  Scenario: User checks in
    Given I am logged in
    When I click "IN" in the QuickStat tool
    Then the QuickStat tool should report me as "IN"

  Scenario: Logged out user can't change state
    Given I am not logged in
    Then the QuickStat tool should have its "IN" button disabled
    And the QuickStat tool should have its "OUT" button disabled
