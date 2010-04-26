@https://www.pivotaltracker.com/story/show/1808615
Feature: Add timestamps of start and end of filling
  In order to know time spent on each questinnaire
  As a supervisor
  I want to store start and finish time of filling

  Scenario: Start and finish
    Given I fill in both parts of questionnaire
    When I follow 'Verze k tisku'
    Then I should see 'Začátek:' and time
    Then I should see 'Konec:' and time
