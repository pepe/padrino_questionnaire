@https://www.pivotaltracker.com/story/show/1798908 @list
Feature: Create list of all filled questionnaires
  In order to have overview of all filled in questionnaires
  As a supervisor
  I want list of them all with expandable detail

  Scenario: Simple list
    Given I know 2 questionnaires were filled in
    And I visit '/list'
    Then I should see 'Výpis všech dotazníků'
    And I should see 'Počet dotazníků v systému:' followed by number
    And I should see unique code
    And I should see 'v' and time

  Scenario: Detail link
    Given I know 2 questionnaires were filled in
    And I visit '/list'
    When I follow unique code
    And I should see 'Vyplněný dotazník'
