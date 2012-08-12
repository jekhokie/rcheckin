@javascript
Feature: Render Mobile Version of Application
  In order to stay in touch when traveling
  A user
  Should be able to view RCheckin on mobile devices

  Scenario: User accesses site with mobile device
    Given I am using a mobile device
    When I make a web request to access the RCheckin application
    Then I should be able to view the site in mobile format

  Scenario: User accesses site with non-mobile device
    Given I am not using a mobile device
    When I make a web request to access the RCheckin application
    Then I should be able to view the site in non-mobile format
