Feature: Calculating the midpoint
  In order to choose a place to meet
  As an organizer
  I want to be told the midpoint between two addresses

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with "363 Clementina St"
      And I fill in "Address 2" with "506 Clement Street"
      And I click "Bunch us"
    Then a map should be displayed with "2" origins

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with "363 Clementina St"
      And I fill in "Address 2" with "Googleplex"
      And I click "Bunch us"
    Then "Addresses must be in SF!" should be displayed

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with "363 Clementina St"
      And I fill in "Address 2" with "xdcyvhbjkn"
      And I click "Bunch us"
    Then "Not a valid address" should be displayed

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with ""
      And I fill in "Address 2" with "363 Clementina St"
      And I click "Bunch us"
    Then "Please enter at least two addresses!" should be displayed

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with "363 Clementina St"
      And I fill in "Address 2" with ""
      And I click "Bunch us"
    Then "Please enter at least two addresses!" should be displayed