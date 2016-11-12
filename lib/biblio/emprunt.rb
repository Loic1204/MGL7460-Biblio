# -*- coding: utf-8 -*-
module Biblio


  #
  # Objet valeur simple -- non modifiable une fois créé, mais peut être détruit.
  #
  class Emprunt
    include Comparable
    include Exceptions

    attr_reader :nom, :courriel, :titre, :auteurs

    def initialize( nom, courriel, titre, auteurs, perdu = false )
      DBC.requires courriel =~ UN_COURRIEL, "Format invalide de courriel: #{courriel}!?"

      @nom = nom
      @courriel = courriel
      @titre = titre
      @auteurs = auteurs
      @perdu = perdu
    end


    # Formate un emprunt selon les indications spécifiées par le_format:
    #   - %N: Nom de l'emprunteur
    #   - %C: Courriel de l'emprunteur
    #   - %T: Titre du document emprunté
    #   - %A: Auteurs du document emprunté
    # Des indications de largeur, justification, etc. peuvent aussi être spécifiées,
    # par exemple, %-10A, %-.10A, etc.
    #
    def to_s( le_format = "[ %N %C '%T' '%A' ]" )
      items = { ?N => nom, ?C => courriel, ?T => titre, ?A => auteurs }

      le_format = le_format.dup # Ne doit pas etre modifie pour d'autres appels subsequents possibles

      args = []
      while m = /^.*?%(-?\d*\.?\d*)([NCTA])/.match( le_format ) do
        # On a trouve un format.
        # On conserve l'argument associe
        position_item = m.begin(2)
        args << items[le_format[position_item]]

        # Et on transforme l'indicateur de format en un indicateur pour string
        le_format[position_item] = "s"
      end
      sprintf le_format, *args
    end


    # Ordonne selon le nom en premier, puis selon le titre.
    #
    def <=>( autre )
      rel_nom = self.nom <=> autre.nom
      return rel_nom unless rel_nom == 0

      rel_titre = self.titre <=> autre.titre
      return rel_titre unless rel_titre == 0

      return 0 if self.courriel == autre.courriel &&
        self.auteurs == autre.auteurs &&
        self.perdu? == autre.perdu?

      DBC.assert false, "Cas impossible: #{self} <=> #{autre} "
    end


    # Effectue le rappel, par courriel, de l'emprunt.
    #
    def rappeler
      Debug.log( "Emprunt#rappeler[#{self.inspect}]()" )

      fail ErreurAucuneAdresseCourriel, "titre = '#{titre}'; emprunteur = #{nom}" if courriel == "@"

      ServicesExternes.courriel.envoyer_courriel( courriel, "Retour d'un livre", message_courriel )
    end


    def indiquer_perte
      @perdu = true
    end

    def perdu?
      @perdu
    end

    private

    def message_courriel  #:nodoc:
      return <<-FIN_MESSAGE
        Bonjour.

        Il y a quelque temps, je t'ai prêté le livre suivant:
        \t'#{titre}'
        S.V.P. Pourrais-tu me le rapporter?

        Si je ne suis pas à mon bureau, tu peux laisser le livre au secrétariat du département
        (le glisser dans la boîte de courrier si le secrétariat est fermé).

        Merci.

        Guy T.
        FIN_MESSAGE
    end

  end

end

