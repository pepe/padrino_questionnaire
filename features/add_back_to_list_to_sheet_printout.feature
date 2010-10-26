@https://www.pivotaltracker.com/story/show/5885965 @list @ux
Feature: Add back to list to sheet printout
  In order to have chance to get back from sheet printout to list
  As a any user
  I want to have back link there

  Scenario: Link back to list
    Given I know 2 questionnaires were filled in
    And I visit '/list'
    When I follow unique code
    Then I should see 'Zpět na výpis'

  Scenario: Get back from list
    Given I know 2 questionnaires were filled in
    And I visit '/list'
    And I follow unique code
    When I follow 'Zpět na výpis'
    Then I should see 'Výpis všech dotazníků'
