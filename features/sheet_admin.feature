@https://www.pivotaltracker.com/story/show/1930014
Feature: 'Rozcestnik'
  In order to have one place for administering questionnaires
  As admin
  I need both links under admin

  Scenario: Admin wants to have sheet admin page
    Given I know 2 questionnaires were filled in
    And I logged in as admin
    When I follow 'Sheets'
    Then I should see 'All Sheet'
    And I should not see 'Important gathering'
    And I should see 'Finished at'
    And I should see 'Id'

  Scenario: Admin wants to see detail of sheet
    Given I know 2 questionnaires were filled in
    And I logged in as admin
    When I follow 'Sheets'
    And I follow first sheet detail
    Then I should see 'Vyplněný dotazník'



