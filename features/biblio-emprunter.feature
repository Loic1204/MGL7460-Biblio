Feature: Emprunt d'un livre
 
  @avec_depot_emprunts_txt
  Scenario : J'emprunte un document disponible avec un format d'adresse courriel valide
    Given un emprunt "e1" fait par "toto" ["@"] pour "The Martian" de "Andy Weir"
  
    When j'emprunte l'emprunt "e1" 

    Then il y a 4 emprunts 
    And l'emprunteur de "The Martian" est "toto"


  Scenario : J'emprunte un document disponible avec un format d'adresse courriel non valide
    Given un emprunt "e2" fait par "toto" ["@"] pour "The Martian" de "Andy Weir"

    When j'emprunte l'emprunt "e1" 

    Then il y a 3 emprunts


  Scenario : Je veux emprunter un document deja emprunte avec un format d'adresse courriel valide
    Given un emprunt "e3" fait par "toto" ["@"] pour "Les Miserables" de "Victor  Hugo"

    When j'emprunte l'emprunt "e3" 

    Then il y a 3 emprunts 


  Scenario : Je veux emprunter un document non present dans la base de donnees avec un format d'adresse courriel valide
    Given un emprunt "e4" fait par "fred" ["@"] pour "Les Miserables" de "Victor  Hugo"

    When j'emprunte l'emprunt "e3" 

    Then il y a 3 emprunts 





  
