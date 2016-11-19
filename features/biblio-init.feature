Feature: Je veux initialiser un depot

  Scenario: Il n'existe pas encore de base de donnees et on en cree une sans specifier de nom

    Given il n'existe pas de fichier ".biblio.txt"

    When je cree un depot sans nom

    Then le fichier ".biblio.txt" existe


  Scenario: Il n'existe pas encore de base de donnees et on en cree une en specifiant le nom

    Given il n'existe pas de fichier ".test.txt"

    When je cree un depot texte "test"

    Then le fichier ".test.txt" existe


  Scenario: Il existe deja une base de donnees et on en cree une nouvelle en detruisant l'ancienne, pas de nom specifie

    Given il existe un fichier ".biblio.txt"

    When je cree un depot texte sans nom en indiquant de le detruire s'il existe

    Then le fichier ".biblio.txt" existe


  Scenario: Il existe deja une base de donnees et on en cree une nouvelle en detruisant l'ancienne, on specifie le nom

    Given il existe un fichier ".test.txt"

    When je cree un depot texte sans nom en indiquant de le detruire s'il existe

    Then le fichier ".test.txt" existe
