Feature: Je veux indiquer la perte d'un document

  @avec_depot_emprunts_txt
  Scenario: Le document n'est pas perdu et on indique sa perte
  
    When j'indique que l'emprunt "Harry Potter" est perdu

    Then l'emprunt "Harry Potter" est considere comme etant perdu


  @avec_depot_emprunts_txt
  Scenario: Le document est deja perdu et on indique sa perte
  
    When j'indique que l'emprunt "Silo" est perdu

    Then l'emprunt "Silo" est considere comme etant perdu
