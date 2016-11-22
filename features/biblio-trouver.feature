Feature: Je veux avoir la liste des documents dont le titre correspond a un extrait

  @avec_depot_emprunts_txt
  Scenario: Aucun document ne correspond a l'extrait
  
    When je trouve les emprunts dont le titre matche "Code Complete 2: now it's complete"
    Then on retourne la table
      |titre|


  @avec_depot_emprunts_txt
  Scenario: Plusieurs documents correspondent a l'extrait
  
    When je trouve les emprunts dont le titre matche "er"
    Then on retourne la table
      |titre         |
      |Harry Potter  |
      |Les Miserables|
