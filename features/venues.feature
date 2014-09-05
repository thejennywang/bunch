Feature: Displaying venue suggestions
  In order to choose a place to meet
  As an organizer
  I want to be shown recommended venues near a midpoint

  @javascript
  Scenario:
  	Given I have filled in addresses and gone to the map page
			And a map should be displayed with "2" origins and a midpoint
		When I click "Find a venue"
  	Then I should see a list of venue recommendations
  	And I should see "4" venue details
