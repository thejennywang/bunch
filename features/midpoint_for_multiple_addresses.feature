Feature: Calculating the midpoint
  In order to choose a place to meet
  As an organizer with many friends
  I want to be told the midpoint between multiple addresses

  @javascript
  Scenario:
    Given I am on the homepage
    Then I should see 2 address fields

  @javascript
  Scenario: 
    Given I am on the homepage
      And I fill in "Address 1" with "363 Clementina St"
      And I fill in "Address 2" with "506 Clement Street"
    Then I should see a new address field

  @javascript
  Scenario: 
    Given I am on the homepage
      And I have filled in 2 addresses
      And submit a blank address
    Then a map should be displayed with "2" origins 

  @javascript
  Scenario: 
    Given I am on the homepage
      And I have filled in 2 addresses
      And I fill in "Address 3" with "506 Clement Street"
      And I click "Bunch us"
    Then a map should be displayed with "3" origins 