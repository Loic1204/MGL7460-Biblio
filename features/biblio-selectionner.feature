Feature: Selectionner les emprunts faits par une personne
  #En tant qu'utilisateur
  #Je veux selectionner les emprunts d une personne
  #Afin de pouvoir les afficher

  @avec_depot_emprunts_txt
  Scenario: Je selectionne les emprunts faits par une personne qui n'a aucun emprunts
    When je selectionne les emprunts faits par "George"

    Then 0 documents ont ete affiches

  @avec_depot_emprunts_txt
  Scenario: Je selectionne les emprunts faits par une personne qui a des emprunts
    When je selectionne les emprunts faits par "Sarah"

    Then 1 documents ont ete affiches
    And on retourne 
      """
      Harry Potter
      """

