Feature: New feature
  In order to login to app
  admin
  wants login page

  Scenario: Coming to login page
    Given I visit '/admin/sessions/new'
    Then I should see 'Questionnaire Admin'
    And I should see 'Login Box'

  Scenario: Logging to dashboard
    Given I have admin 'god@laststar.cz' with password 'hides'
    And I visit '/admin/session/new'
    And I fill in 'god@laststar.cz' for 'email'
    And I fill in 'hides' for 'password'
    And I press 'Sign In'
    Then I should see 'Dashboard'

  Scenario: Logout from admin
    Given I logged in as admin
    When I follow 'Logout'
    Then I should see 'Login Box'
