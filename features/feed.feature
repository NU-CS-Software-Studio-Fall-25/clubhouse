Feature: Main events feed
  As a user
  I want to see all upcoming events
  So I can know what is happening on campus

  Scenario: User views the feed
    Given there are events "Hack Night" and "Board Game Night"
    And I am logged in
    When I visit the events page
    Then I should see "Hack Night"
    And I should see "Board Game Night"
