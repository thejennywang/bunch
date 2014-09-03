Feature: Calculating the midpoint
  In order to choose a place to meet
  As an organizer
  I want to be told the midpoint between two addresses

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with "25 City Road"
    And I fill in "Address 2" with "24 Gales Gardens"
    And I click "Bunch us"
    Then a map should be displayed with the origins and a midpoint

  @javascript
  Scenario: 
    Given I am on the homepage
    When I fill in "Address 1" with "25 City Road"
    And I fill in "Address 2" with "Glasgow"
    And I click "Bunch us"
    Then "Please enter an address in London" should be displayed


