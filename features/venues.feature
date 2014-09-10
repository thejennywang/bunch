Feature: Displaying venue suggestions
  In order to choose a place to meet
  As an organizer
  I want to be shown recommended venues near a midpoint

  @javascript
  Scenario:
  	Given I have filled in addresses and gone to the map page
  	Then a map should be displayed with "2" origins
  		And I should see a list of venue recommendations
  		And I should see "3" venue details
  		And I should see "3" venue markers on the map

  @javascript
  Scenario:
    Given I have filled in addresses and gone to the map page
    When I click on the drinks icon
    Then I should see a fresh set of recommendations on the map
