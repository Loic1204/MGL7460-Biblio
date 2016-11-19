Feature: Je veux pouvoir indiquer le nom de l'emprunteur d'un document

  @avec_depot_emprunts_txt
  Scenario: Le document n'est pas emprunte et on retourne une erreur
  
    When je retourne l'emprunteur de l'unique emprunt dont le titre matche "Code Complete 2: now it's complete"
    Then on retourne une erreur


  @avec_depot_emprunts_txt
  Scenario: Le document est emprunte et on indique son emprunteur
  
    When je retourne l'emprunteur de l'unique emprunt dont le titre matche "Harry Potter"
    Then le nom retourne est "Sarah"


  @avec_depot_emprunts_txt
  Scenario: Le document est perdu et on indique son emprunteur
  
    When je retourne l'emprunteur de l'unique emprunt dont le titre matche "Silo"
    Then le nom retourne est "Celine"
