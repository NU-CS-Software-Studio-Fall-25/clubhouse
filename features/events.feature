Feature: Managing events
  As a club leader
  I want to create events
  So my club can host activities

  Scenario: User sees a club's events
    Given a club "Chess Club" has an event "Weekly Meeting"
    And I am logged in
    When I visit the club page for "Chess Club"
    Then I should see "Weekly Meeting"

  Scenario: Club owner creates an event
    Given I am the owner of a club named "Chess Club"
    When I visit the new event page for "Chess Club"
    And I fill in "Name" with "Board Game Night"
    And I fill in "Date" with "2025-02-01"
    And I press "Create Event"
    Then I should see "Event created!"

  Scenario: User RSVPs to an event
    Given an event "Board Game Night" exists
    And I am logged in
    When I visit the event page for "Board Game Night"
    And I press "RSVP"
    Then I should see "RSVP Successful!"

