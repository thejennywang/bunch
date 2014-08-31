
Feature: In order to choose a place to meet
As an organizer
I want to be told the midpoint between two addresses

Scenario: Given I am on the homepage
Wen I enter my London address
And I enter my friend’s London address
And I click ‘Bunch’
Then I should see the midpoint displayed on the map

Scenario: Given I am on the homepage
When I submit bunch with one address outside London
Then I will see an error message