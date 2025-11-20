Feature: Managing clubs
  Scenario: User views a list of clubs
    Given I am logged in
    When I visit the clubs page
    Then I should see a list of clubs

  Scenario: User views a club page
    Given a club exists named "Chess Club"
    And I am logged in
    When I visit the club page for "Chess Club"
    Then I should see "Chess Club"

  Scenario: User joins a club
    Given a club exists named "Chess Club"
    And I am logged in
    When I visit the club page for "Chess Club"
    And I press "Join Club"
    Then I should see "You have joined the club!"

  Scenario: User leaves a club
    Given I am logged in
    And I have joined the club "Chess Club"
    When I visit the club page for "Chess Club"
    And I press "Leave Club"
    Then I should see "You have left the club"

  Scenario: Club owner edits club info
    Given I am the owner of a club named "Chess Club"
    When I visit the Edit Club page for "Chess Club"
    And I fill in "Description" with "New description"
    And I press "commit"
    Then I should see "Club was successfully updated"
