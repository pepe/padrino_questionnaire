@https://www.pivotaltracker.com/story/show/3500758
Feature: Sheet admin links
  In order to see links to other parts of system
  As admin
  I want them in Sheet Admin Sidebar

  Scenario: Sheet Admin Sidebar on Index
    Given I logged in as admin
    When I follow 'Sheets'
    Then I should see 'Public list'
    And I should see 'Public stats'

  Scenario: Link to Public List
    Given I logged in as admin
    And I follow 'Sheets'
    When I follow 'Public list'
    Then I should see 'Výpis všech dotazníků'

  Scenario: Link to Public Statistics
    Given I logged in as admin
    And I follow 'Sheets'
    When I follow 'Public stats'
    Then I should see 'Statistika dotazníku'

