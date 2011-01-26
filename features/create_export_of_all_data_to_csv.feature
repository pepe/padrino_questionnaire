@https://www.pivotaltracker.com/story/show/1798967 @export
Feature: Create export of all data to CSV
  In order to load all data to statistical program
  As a supervisor
  I want to have export function to CSV formatted file

  Scenario: Link on List page
    Given I visit '/list'
    Then I should see 'Stáhnout v CSV'

  Scenario: Download list
    Given I know 2 questionnaires were filled in
    And I visit '/list'
    And I follow 'Stáhnout v CSV'
    Then I should receive CSV file

  Scenario: File structure
    Given I know 2 questionnaires were filled in
    And I visit '/list.csv'
    Then file should have 3 lines
    And line should have 21 items separated by ';'
    And 1. item should be uniq code
    And 2. item should be date
    And 3. item should be date
    And 4. item should be number



