Feature: Permissions
  As a user
  I should only be allowed to edit what I own

  Scenario: Normal user cannot edit another user's club
    Given a club exists named "Chess Club" owned by another user
    And I am logged in as a different user
    When I visit the club page for "Chess Club"
    Then I should not see "Edit Club"

  Scenario: Normal user cannot create events for a club they don't own
    Given a club "Photography Club" exists and is owned by someone else
    And I am logged in
    When I visit the new event page for "Photography Club"
    Then I should see "You must be a member"
