# -*- coding: utf-8 -*-
module IPM

  # Pour obtenir un argument matchant un patron sur stdin.
  #
  module Arguments

    # Un ou des mots représentant nom, titre, auteurs.
    #
    UN_OU_DES_MOTS = /"([^"]+)"|'([^']+)'|([^\s]+)/

    # Une adresse de courriel, qui peut être vide.
    #
    UN_COURRIEL = /([\w\.]*@[\w\.]*)/

    # Obtient le prochain jeton sur la ligne, qui doit matcher le patron indiqué.
    #
    def self.prochain( ligne, patron )
      ligne.strip!
      m = patron.match(ligne)

      return nil,nil unless m

      1.upto(m.size) do |i|
        # Il y a plusieurs possibilites de match, mais une seule effective:
        #  on la trouve et on la retourne.
        return m[i], m.post_match if m[i]
      end
    end

  end

end
