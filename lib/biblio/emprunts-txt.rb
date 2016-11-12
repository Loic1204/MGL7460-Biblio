# -*- coding: utf-8 -*-
module Biblio

  # Opérations pour charger/sauvegarder un dépôt d'emprunts en format texte simple.
  class EmpruntsTxt

    extend EmpruntsTexte

    private

    SEPARATEUR = "%"

    def self.emprunts_pour( fich_depot )
      les_emprunts = {}
      IO.readlines(fich_depot).each do |l|
        l.chomp!
        nom, courriel, titre, auteurs, perdu = *l.split(SEPARATEUR)
        e = Emprunt.new( nom, courriel, titre, auteurs, perdu == "true" )
        les_emprunts[e.titre] = e
      end
      les_emprunts
    end

    def self.sauvegarder_depot_existant( fich_depot, les_emprunts )
      File.open( fich_depot, File::CREAT | File::WRONLY | File::TRUNC ) do |depot|
        les_emprunts.values.each do |emp|
          depot.puts( [emp.nom, emp.courriel, emp.titre, emp.auteurs, emp.perdu?].join(SEPARATEUR) )
        end
      end
    end
  end
end

