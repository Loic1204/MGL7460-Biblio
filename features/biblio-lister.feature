Feature: Je veux avoir la liste des emprunts selon leurs statuts

  @avec_depot_emprunts_txt
  Scenario: Les documents qui ne sont pas perdus sont listes
  
    When je liste les emprunts qui ne sont pas perdus
    Then on retourne 'Sarah :: [ JK Rowling ] "Harry Potter"\nJean :: [ Victor Hugo ] "Les Miserables"'


  @avec_depot_emprunts_txt
  Scenario: Tous les documents sont listes
  
    When je liste tous les emprunts
    Then on retourne 'Sarah :: [ JK Rowling ] "Harry Potter"\nJean :: [ Victor Hugo ] "Les Miserables"\nCeline :: [ Hugh Howey ] "Silo" <<PERDU>> '
