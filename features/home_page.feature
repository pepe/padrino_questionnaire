@http://www.pivotaltracker.com/story/show/1798874 @static
Feature: Create home page with basic information
  In order to have basic information about project
  As a random visitor
  I want home page with basic informations

  Scenario: Home page
    Given I visit '/'
    Then I should see 'Vážení přátelé lesa,'
    And I should see 'dotazník zabývající se funkcemi lesa byl dočasně pozastaven. Další vlna šetření bude pravdě- podobně spuštěna na začátku zimního semestru 2011/2012.'
    And I should see 'Výsledky šetření budou zveřejněny na této webové stránce, jakmile budou zpracovány.'
    And I should see 'Děkujeme Vám za Vaši návštěvu.'
    And I should see 'Za výzkumný tým'
    And I should see 'Ing. Vendula Pospíšilová'
