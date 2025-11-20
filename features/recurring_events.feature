Feature: Recurring events
  As a club leader
  I want to create recurring weekly events
  So I don't have to create each one manually

  Scenario: User creates a recurring event
    Given I am the owner of a club named "Chess Club"
    When I visit the new event page for "Chess Club"
    And I fill in "Name" with "Weekly Meeting"
    And I fill in "Date" with "2025-03-01"
    And I check "Recurring"
    And I fill in "End Date" with "2025-04-01"
    And I press "Create Event"
    Then I should see "recurring events were created"
    And I should see multiple future events created
