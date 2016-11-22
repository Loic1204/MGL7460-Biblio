Feature: Je veux pouvoir supprimer des emprunts qu'on me rapporte

  @avec_depot_emprunts_txt
  Scenario: Je supprime un emprunt pour un titre specifique
  
    When je rapporte un emprunt dont le titre est "Harry Potter"

    When je selectionne l'emprunt dont le titre matche "Harry Potter"
    Then 0 document a ete selectionne


  @avec_depot_emprunts_txt
  Scenario: Je supprime un emprunt perdu pour un titre specifique
  
    When je rapporte un emprunt dont le titre est "Silo"

    When je selectionne l'emprunt dont le titre matche "Silo"
    Then 0 document a ete selectionne
