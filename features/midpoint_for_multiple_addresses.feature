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