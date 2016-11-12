# -*- coding: utf-8 -*-
module Biblio
  require 'yaml/store'

  # Opérations pour charger/sauvegarder un dépôt d'emprunts en format YAML.
  class EmpruntsYAML

    extend EmpruntsTexte

    private

    def self.emprunts_pour( fich_depot )
      les_emprunts = {}
      if File.size( fich_depot ) != 0
        store = YAML::Store.new fich_depot
        store.transaction(true) do
          les_emprunts = store['emprunts']
        end
      end
      les_emprunts
    end

    def self.sauvegarder_depot_existant( fich_depot, les_emprunts )
      store = YAML::Store.new fich_depot
      store.transaction do
        store['emprunts'] = les_emprunts
      end
    end

  end
end

