# -*- coding: utf-8 -*-
module Biblio

  #
  # Opérations pour charger/sauvegarder un dépôt d'emprunts en format "texte"
  #
  # Le module definit une methode commune et deux methodes partiellement
  # definies, qui reposent sur deux autres methodes (emprunts_pour
  # et sauvegarder_depot_existant) definies dans les classes qui extensionnent.
  #

  module EmpruntsTexte

    def creer_depot( fich_depot, opts = {:detruire_si_existe => false} )
      DBC.requires !FileTest.exists?(fich_depot) || opts[:detruire_si_existe]

      detruire = opts && opts[:detruire_si_existe]

      FileUtils.rm_f( fich_depot ) if FileTest.exists?( fich_depot ) && detruire
      FileUtils.touch( fich_depot )
    end


    def charger( fich_depot )
      DBC.requires FileTest.exists?(fich_depot), "Le fichier #{fich_depot} ne semble pas exister!?"

      emprunts_pour( fich_depot )
    end


    def sauvegarder( fich_depot, les_emprunts )
      DBC.requires FileTest.exists?(fich_depot), "Le fichier #{fich_depot} ne semble pas exister!?"

      sauvegarder_depot_existant( fich_depot, les_emprunts )
    end

  end

end

