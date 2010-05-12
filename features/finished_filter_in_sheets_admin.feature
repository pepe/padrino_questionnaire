@https://www.pivotaltracker.com/story/show/3499359
Feature: Finished filter in sheets admin
  In order to see only finished sheets
  As admin
  I need filter link on sheet admin page

  Scenario: Activate finished filter
    Given I know 2 questionnaires were filled in
    And I know 2 questionnaires were just started
    And I logged in as admin
    And I follow 'Sheets'
    When I follow 'Finished'
    Then I should see 'Finished Sheet'

