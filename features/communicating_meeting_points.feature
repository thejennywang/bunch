Feature: Communicating a meeting point
  In order to make sure everyone knows where to meet
  As an organizer with many friends
  I want to text my chosen meeting place to everyone in our group

  @javascript
  Scenario: 
    Given I have chosen a meeting place
    When I click the phone button
    	And I fill in my friends' details
    Then all the group receive a text with the meeting details