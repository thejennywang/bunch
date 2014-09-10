Feature: Calculating the midpoint
  In order to choose a place to meet
  As an organizer with many friends
  I want to be told the midpoint between multiple addresses

  @javascript
  Scenario:
    Given I am on the homepage
    When I click "+"
    Then I should see a new address field

  @javascript
  Scenario:
    Given I am on the homepage
      And there are five address fields
    Then the + button is disabled

  @javascript
  Scenario: 
    Given I am on the homepage
      And I have filled in 2 addresses
    When I click "+"
      And I fill in "Address 3" with "70 Monnow Road"
      And I click "Bunch us"
    Then a map should be displayed with "3" origins 

  @javascript
  Scenario: 
    Given I am on the homepage
      And I have filled in 2 addresses
    When I fill in another address
      And submit two blank addresses
    Then a map should be displayed with "3" origins 