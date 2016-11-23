Feature: Emprunt d'un livre
 
  @avec_depot_emprunts_txt
  Scenario Outline: J'emprunte un document disponible avec un format d'adresse courriel valide
    When j'emprunte l'emprunt "<e>" pour "<nom>" de courriel "<courriel>" pour le document "<titre>" ecrit par "<auteurs>"

    Then il y a "<nb>" emprunts 
    And l'emprunteur de "<titre>" est "<nom>"

    Examples:
    | e  | nom  | courriel                  | titre                    | auteurs      | nb |
    | e1 | toto | @                         | The Martian              | Andy Weir    | 4  |
    | e2 | Jean | jean@truc.ca              | The Cursed Child         | JK Rowling   | 5  |
    | e3 | Jean | j.dupont@courriel.truc.ca | The Hexed Grandkid       | JK Rowling   | 6  |


  @avec_depot_emprunts_txt
  Scenario Outline: J'emprunte un document disponible avec un format d'adresse courriel non valide
    When j'emprunte l'emprunt "<e>" pour "<nom>" de courriel "<courriel>" pour le document "<titre>" ecrit par "<auteurs>"

    Then il y a "<nb>" emprunts

    Examples:
    | e  | nom  | courriel                  | titre                    | auteurs      | nb |
    | e1 | toto | mauvaiscourriel           | The Martian 2            | Andy Weir    | 6  |


  @avec_depot_emprunts_txt
  Scenario Outline: Je veux emprunter un document deja emprunte avec un format d'adresse courriel valide
    When j'emprunte l'emprunt "<e>" pour "<nom>" de courriel "<courriel>" pour le document "<titre>" ecrit par "<auteurs>"

    Then il y a "<nb>" emprunts 
   

    Examples:
    | e  | nom  | courriel                  | titre                    | auteurs      | nb |
    | e1 | toto | @                         | Les Miserables           | Victor Hugo  | 6  |
    | e2 | toto | @                         | Harry Potter             | JK Rowling   | 6  |
    | e3 | toto | @                         | Silo                     | Hugh Howey   | 6  |
