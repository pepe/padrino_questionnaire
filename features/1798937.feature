@https://www.pivotaltracker.com/story/show/1798937 @statistics
Feature: Create page with simple statistics
  In order to have access to simple statistics
  As a supervisor
  I want to have page where I can see count summary, counts by time range

  Scenario:
    Given I know 2 questionnaires were filled in
    When I visit '/stats'
    Then I should see 'Statistika dotazníku'
    And I should see 'Jak často navštěvujete les v průměru ročně'
    And I should see 'none: 2 (100%)'
    And I should see 'Jak dlouhou dobu obvykle trávíte návštěvou lesa?'
    And I should see 'min: 10'
    And I should see 'max: 10'
    And I should see 'avg: 10'
    And I should see 'Za jakým účelem obvykle navštěvujete les'
    And I should see 'pro duševní a fyzickou relaxaci, rekreaci'
    And I should see 'pro zájmovou činnost (sport, příroda, myslivost, poznávání apod.)'
    And I should see 'pro sběr lesních plodin (včetně léčivých rostlin)'
    And I should see 'pro sběr paliva'
    And I should see 'Kolik byste byli ochotni zaplatit peněz za jednorázovou návštěvu Vašeho oblíbeného lesa, aniž byste se jí vzdali'
    And I should see 'Jakou částku byste byli ochotni jednorázově přijmout výměnou za trvalé znemožnění návštěvy Vašeho oblíbeného lesa'
    And I should see 'Jaká je podle vás významnost funkcí lesa v České republice?'
    And I should see 'produkce a využití dříví'
    And I should see 'produkce a sběr lesních plodin (včetně hub a léčivých rostlin)'
    And I should see 'vodohospodářské funkce'
    And I should see 'půdoochranné funkce'
    And I should see 'klimatické funkce'
    And I should see 'přírodoochranné funkce'
    And I should see 'Jaký je váš vztah k České zemědělské univerzitě v Praze'
    And I should see 'student'
