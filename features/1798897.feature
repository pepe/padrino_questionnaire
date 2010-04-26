@https://www.pivotaltracker.com/story/show/1798897
Feature: Create thank-you page
  In order to get respondent contact
  As a supervisor
  I want last page of questionnaire with thanks and contact form

  Scenario: Note and contact information
    Given I fill in both parts of questionnaire
    Then I should see 'Děkujeme za Vaše podněty a názory.'
    And I should see 'Děkujeme za Váš čas, který jste věnovali vyplnění tohoto dotazníku. V případě, že byste rádi jakýmkoliv způsobem okomentovali dotazník a tím se podíleli na jeho budoucím zkvalitnění, máte prostor níže.'
    And I should see 'Pokud budete mít zájem o zaslání výsledků tohoto průzkumu, vypište prosím níže Vaši emailovou adresu. Výsledky Vám budou zaslány po závěrečném zpracování dat. Průzkum je zcela anonymní, Vaše emailová adresa nebude použita pro žádné jiné účely.'
    When I fill in 'je super!' for 'Komentář'
    And I fill in 'example@example.org' for 'email'
    And I press 'Dokončit dotazník a přejít na úvodní stránku'
    Then I should see 'Základní informace o dotazníku'
