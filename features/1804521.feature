@https://www.pivotaltracker.com/story/show/1804521 @core
Feature: Add saving to database
  In order to check my questionnaire later
  As a respondent
  I want to have my code on thank you page and address for review my answers

  Scenario: Getting code and permalink
    Given I fill in both parts of questionnaire
    Then I should see 'Unikátní kód Vašeho dotazníku je:'
    And I should see unique code
    When I follow 'Verze k tisku'
    And I should see 'Vyplněný dotazník'
    And I should see 'Jak často navštěvujete les v průměru ročně: none'
    And I should see 'Jak dlouhou dobu obvykle trávíte návštěvou lesa: 10'
    And I should see 'Za jakým účelem obvykle navštěvujete les:'
    And I should see 'pro duševní a fyzickou relaxaci, rekreaci: 1'
    And I should see 'pro zájmovou činnost (sport, příroda, myslivost, poznávání apod.): 1'
    And I should see 'pro sběr lesních plodin (včetně léčivých rostlin): 1'
    And I should see 'pro sběr paliva: 1'
    And I should see 'Které je Vaše oblíbené území lesa: nahoře'
    And I should see 'Kolik byste byli ochotni zaplatit peněz za jednorázovou návštěvu Vašeho oblíbeného lesa, aniž byste se jí vzdali: 10'
    And I should see 'Jakou částku byste byli ochotni jednorázově přijmout výměnou za trvalé znemožnění návštěvy Vašeho oblíbeného lesa: 10'
    And I should see 'Jaká je podle vás významnost funkcí lesa v České republice:'
    And I should see 'produkce a využití dříví: 1'
    And I should see 'produkce a sběr lesních plodin (včetně hub a léčivých rostlin): 1'
    And I should see 'vodohospodářské funkce: 1'
    And I should see 'půdoochranné funkce: 1'
    And I should see 'klimatické funkce: 1'
    And I should see 'zdravotně hygienické funkce (rekreační, zdravotní): 1'
    And I should see 'přírodoochranné funkce: 1'
    And I should see 'Jaký je váš vztah k České zemědělské univerzitě v Praze: student'

