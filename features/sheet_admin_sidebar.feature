@https://www.pivotaltracker.com/story/show/3500487 @layout
Feature: Sheet Admin Sidebar
  In order to have some basic information about sheet admin
  As admin
  I wanna have them in sheet admin sidebar

  Scenario: Sheet Admin Sidebar on Index
    Given I logged in as admin
    When I follow 'Sheets'
    Then I should see 'Sheet Admin'
    And I should see 'Basic information about sheets administration'
    
  Scenario: Sheet Admin Sidebar on Finished
    Given I logged in as admin
    And I follow 'Sheets'
    When I follow 'Finished'
    Then I should see 'Sheet Admin'
    And I should see 'Basic information about sheets administration'
