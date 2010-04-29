@http://www.pivotaltracker.com/story/show/1798886 @form
Feature: Create form with questions in two steps
  In order to have form for filling in the questionnaire
  As a respondent
  I want form pages with two steps

  Scenario: First part questions
    Given I started new questionnaire
    And I should see 'Dotazník I. část'
    And I should see 'Jak často navštěvujete les v průměru ročně?'
    And I should see 'prosím zaklikněte'
    And I should see 'Jak dlouhou dobu obvykle trávíte návštěvou lesa?'
    And I should see 'Za jakým účelem obvykle navštěvujete les?'
    And I should see 'Které je Vaše oblíbené území lesa?'

  Scenario: First part of questionnaire
    Given I started new questionnaire
    And I can choose 'vůbec'
    And I can choose '1 až 2 x ročně'
    And I can choose '1 x měsíčně'
    And I can choose '1 x týdně'
    And I choose '2 až 3 x týdně'
    And I fill in 'nikdy' for 'Jinak často'
    And I fill in '10' for 'hodin'
    And I should see 'pro duševní a fyzickou relaxaci, rekreaci'
    And I select '1' from 'sheet_purpose_relaxation'
    And I select '5' from 'sheet_purpose_relaxation'
    And I should see 'pro zájmovou činnost (sport, příroda, myslivost, poznávání apod.)'
    And I select '1' from 'sheet_purpose_hobbitry'
    And I select '5' from 'sheet_purpose_hobbitry'
    And I should see 'pro sběr lesních plodin (včetně léčivých rostlin)'
    And I select '1' from 'sheet_purpose_gathering'
    And I select '5' from 'sheet_purpose_gathering'
    And I should see 'pro sběr paliva'
    And I select '1' from 'sheet_purpose_fuel'
    And I select '5' from 'sheet_purpose_fuel'
    Then I fill in 'nahore' for 'sheet_favorite_place'

  Scenario: Second part questions
    Given I filled first part of questionnaire
    Then I should see 'Dotazník II. část'
    And I should see 'Kolik byste byli ochotni zaplatit peněz za jednorázovou návštěvu Vašeho oblíbeného lesa, aniž byste se jí vzdali?'
    And I should see 'Jakou částku byste byli ochotni jednorázově přijmout výměnou za trvalé znemožnění návštěvy Vašeho oblíbeného lesa?'
    And I should see 'Jaká je podle vás významnost funkcí lesa v České republice?'
    And I should see 'Jaký je váš vztah k České zemědělské univerzitě v Praze?'
    And I should see 'prosím zaklikněte'

  Scenario: Second part of questionnaire
    Given I filled first part of questionnaire
    Then I fill in '10' for 'sheet_once_receive'
    And I fill in '10' for 'sheet_once_payment'
    And I should see 'produkce a využití dříví'
    And I can select '1' from 'sheet_important_wood'
    And I select '5' from 'sheet_important_wood'
    And I should see 'produkce a sběr lesních plodin (včetně hub a léčivých rostlin)'
    And I can select '1' from 'sheet_important_gathering'
    And I select '5' from 'sheet_important_gathering'
    And I should see 'vodohospodářské funkce'
    And I can select '1' from 'sheet_important_water'
    And I select '5' from 'sheet_important_water'
    And I should see 'půdoochranné funkce'
    And I can select '1' from 'sheet_important_ground'
    And I select '5' from 'sheet_important_ground'
    And I should see 'klimatické funkce'
    And I can select '1' from 'sheet_important_climate'
    And I select '5' from 'sheet_important_climate'
    And I should see 'zdravotně hygienické funkce (rekreační, zdravotní)'
    And I can select '1' from 'sheet_important_health'
    And I select '5' from 'sheet_important_health'
    And I should see 'přírodoochranné funkce'
    And I can select '1' from 'sheet_important_nature'
    And I select '5' from 'sheet_important_nature'
    And I can choose 'jsem zaměstnanec/zaměstnankyně'
    And I can choose 'jsem student/studentka'
    And I choose 'žádný'

  Scenario: Full form
    Given I started new questionnaire
    And I select '1' from 'sheet_purpose_relaxation'
    And I select '1' from 'sheet_purpose_hobbitry'
    And I select '1' from 'sheet_purpose_gathering'
    And I select '1' from 'sheet_purpose_fuel'
    And I fill in 'nahore' for 'sheet_favorite_place'
    When I press 'Odeslat I. část'
    Then I should see 'Dotazník II. část'
    And I fill in '10' for 'sheet_once_payment'
    Then I fill in '10' for 'sheet_once_receive'
    And I select '1' from 'sheet_important_wood'
    And I select '1' from 'sheet_important_gathering'
    And I select '1' from 'sheet_important_water'
    And I select '1' from 'sheet_important_ground'
    And I select '1' from 'sheet_important_climate'
    And I select '1' from 'sheet_important_health'
    And I select '1' from 'sheet_important_nature'
    And I choose 'jsem student/studentka'
    When I press 'Odeslat II. část'
    Then I should see 'Děkujeme za Vaše podněty a názory.'
    
